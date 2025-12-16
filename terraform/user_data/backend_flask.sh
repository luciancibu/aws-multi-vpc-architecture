#!/bin/bash
set -eux

APP_DIR=/opt/flask-app
yum update -y
yum install -y python3 python3-pip mysql

mkdir -p $APP_DIR
chown ec2-user:ec2-user $APP_DIR
cd $APP_DIR

sudo -u ec2-user python3 -m venv venv

sudo -u ec2-user $APP_DIR/venv/bin/pip install \
  flask \
  gunicorn \
  pymysql \
  boto3

cat > $APP_DIR/app.py << 'EOF'
from flask import Flask, request
import pymysql
import boto3
import json
import time
import os
import logging

app = Flask(__name__)
_secret_cache = None

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)
logger = logging.getLogger(__name__)

def get_secret():
    global _secret_cache
    if _secret_cache is None:
        client = boto3.client("secretsmanager", region_name="us-east-1")
        _secret_cache = json.loads(
            client.get_secret_value(
                SecretId="backend-mysql-secret"
            )["SecretString"]
        )
    return _secret_cache

def get_conn():
    secret = get_secret()
    return pymysql.connect(
        host=secret["host"],
        user=secret["username"],
        password=secret["password"],
        database=secret["dbname"],
        connect_timeout=5
    )

def ensure_table():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS counter (
            id INT PRIMARY KEY,
            views BIGINT NOT NULL
        )
    """)
    cur.execute("""
        INSERT INTO counter (id, views)
        SELECT 1, 0
        WHERE NOT EXISTS (SELECT 1 FROM counter WHERE id=1)
    """)
    conn.commit()
    conn.close()

@app.route("/view")
def view_counter():
    ensure_table()
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("UPDATE counter SET views = views + 1 WHERE id=1")
    conn.commit()
    cur.execute("SELECT views FROM counter WHERE id=1")
    views = cur.fetchone()[0]
    conn.close()
    return str(views)

@app.route("/health")
def health():
    return "OK"

@app.route("/info")
def info():
    return {"service": "flask-backend"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

chown ec2-user:ec2-user $APP_DIR/app.py

# ---- systemd service ----
cat > /etc/systemd/system/flask-backend.service << EOF
[Unit]
Description=Flask Backend Service
After=network.target

[Service]
User=ec2-user
WorkingDirectory=$APP_DIR
ExecStart=$APP_DIR/venv/bin/gunicorn \
  --workers 2 \
  --bind 0.0.0.0:5000 \
  app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flask-backend
systemctl start flask-backend
