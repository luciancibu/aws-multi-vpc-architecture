## Overview

This project implements a complete **multi-tier web application** deployed on AWS using **Terraform** as Infrastructure as Code (IaC).

The infrastructure is split across **two separate VPCs** to ensure strong isolation between frontend and backend layers.  
The application serves a **static resume website**, tracks page views via a **Flask backend**, and stores view counts in an **RDS MySQL database**.

---

## Architecture Overview

### VPC 1 – Frontend & Entry Point
- **Public Subnet**
  - Application Load Balancer (ALB) – public entry point
- **Private Subnet**
  - EC2 instance running **Nginx**
    - Hosts static frontend (HTML/CSS)
    - Acts as a reverse proxy to the Flask backend in VPC 2

### VPC 2 – Backend & Database
- **Private Subnet**
  - EC2 instance running **Flask (Gunicorn)**
    - Exposes API endpoints for view counting
  - **RDS MySQL**
    - Stores page view counter
    - Accessed only from the Flask backend

### Connectivity
- Secure **VPC Peering** between VPC 1 and VPC 2
- No direct public access to backend or database resources

---

## Request Flow

1. User accesses the website via the **ALB (VPC 1, public subnet)**
2. ALB forwards traffic to **Nginx (private subnet, VPC 1)**
3. Static content is served directly by Nginx
4. JavaScript calls `/view`
5. Nginx proxies `/view` to **Flask backend (VPC 2)**
6. Flask:
   - Increments view counter in **RDS MySQL**
   - Returns the updated value
7. The number of views is displayed dynamically in the HTML page

---

## Components

### Frontend
- Static HTML & CSS
- Hosted by **Nginx**
- Displays page view counter using JavaScript

### Backend
- **Flask** application
- Runs behind **Gunicorn**
- Endpoints:
  - `/view` – increments and returns view count
  - `/health` – health check
- Retrieves DB credentials from **AWS Secrets Manager**

### Database
- **Amazon RDS MySQL**
- Single table storing view count
- Private subnet only

---

## Design

- Backend and database are **not publicly accessible**
- Security Groups restrict traffic:
  - ALB → Nginx
  - Nginx → Flask
  - Flask → RDS
- Database credentials stored securely in **Secrets Manager**
- Network isolation via multiple VPCs

---

## 🛠️ Infrastructure as Code (Terraform)

The project uses Terraform to provision:
- VPCs, subnets, route tables
- Internet Gateway & NAT
- ALB & Target Groups
- EC2 instances
- Security Groups
- RDS instance
- IAM roles and policies


## Concepts

- Multi-VPC architecture
- Private/public subnet separation
- Reverse proxy with Nginx
- Secure backend-to-database communication
- Terraform-based AWS provisioning
- Production-like security best practices

---
