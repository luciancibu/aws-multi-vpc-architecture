#!/bin/bash
set -eux

yum update -y
amazon-linux-extras install nginx1 -y

mkdir -p /var/www/frontend

# index.html
cat > /var/www/frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="x-dns-prefetch-control" content="off">
    <title>Lucian Cibu - Resume</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>

<body>
<div class="page">

    <!-- Header -->
    <header class="header">
        <div class="name-title">
            <h1 class="name">Lucian Cibu</h1>
            <p class="role">Software Engineer</p>
            <p class="location">Cluj-Napoca, Romania</p>
        </div>
        <div class="contact">
            <div class="contact-item">
                <span class="contact-label">Phone</span>
                <a href="tel:+40731910497">+40 731 910 497</a>
            </div>
            <div class="contact-item">
                <span class="contact-label">Email</span>
                <a href="mailto:luciancibu@yahoo.com">luciancibu@yahoo.com</a>
            </div>
            <div class="contact-item">
                <span class="contact-label">LinkedIn</span>
                <a href="https://www.linkedin.com/in/lucian-cibu-18a72523b/" target="_blank">lucian-cibu</a>
            </div>
            <div class="contact-item">
                <span class="contact-label">Website</span>
                <a href="https://resume.lucian-cibu.xyz" target="_blank">resume.lucian-cibu.xyz</a>
            </div>
        </div>
    </header>
    <!-- SUMMARY -->
    <main>
        <section class="section">
            <h2 class="section-title">Summary</h2>
            <p>
                <strong>Software Engineer with 3+ years of experience</strong> in Linux-based systems, automation,
                and deployment workflows on automotive SoCs. Strong background in Python, Bash, C/C++, Docker,
                networking, virtualization, and deep learning pipelines. Hands-on with Linux/QNX development,
                real-time data processing, remote debugging, communication protocols, containerized environments,
                and automation scripts.
            </p>
        </section>


        <!-- SKILLS -->
        <section class="section">
            <h2 class="section-title">Skills</h2>

            <div class="skills-grid">

                <div class="skill-block">
                    <h3>Programming & Tools</h3>
                    <ul>
                        <li>Python, C/C++, Bash</li>
                        <li>Docker, Git, GitHub, CUDA, CMake</li>
                    </ul>
                </div>

                <div class="skill-block">
                    <h3>Infra & AI</h3>
                    <ul>
                        <li>Windows / Linux / QNX</li>
                        <li>SSH, TCP/IP Networking</li>
                        <li>Remote Debugging, Automation Scripting</li>
                        <li>ONNX Runtime, Neural Network Quantization</li>
                        <li>Real-time Image Processing</li>
                        <li>CAN, FlexRay</li>
                    </ul>
                </div>

                <div class="skill-block">
                    <h3>Familiar With</h3>
                    <ul>
                        <li>AWS (EC2, S3, IAM etc.)</li>
                        <li>Terraform (IaC)</li>
                        <li>CI/CD: GitHub Actions, Jenkins, GitLab</li>
                    </ul>
                </div>

                <div class="skill-block">
                    <h3>Other</h3>
                    <ul>
                        <li>Agile / Scrum, Jira</li>
                        <li>Team Collaboration</li>
                        <li>English (Fluent)</li>
                    </ul>
                </div>

            </div>
        </section>



        <!-- EXPERIENCE -->
        <section class="section">
            <h2 class="section-title">Work Experience</h2>

            <!-- Software Engineer -->
            <article class="experience-item">
                <div class="experience-header">
                    <div>
                        <h3>Bosch Engineering Center: Software Engineer</h3>
                        <p class="exp-location">Cluj-Napoca, Romania</p>
                    </div>
                    <div class="exp-dates">2023 – Present</div>
                </div>

                <ul>
                    <li>Implemented end-to-end Python/C++ applications on SoCs, integrating deep learning models.</li>
                    <li>Worked with Python/Bash scripts and containerized environments to support automation pipelines.</li>
                    <li>Managed SSH connectivity between Linux hosts and multiple embedded SoC targets, supporting deployment, monitoring, and debugging.</li>
                    <li>Hands-on experience with Linux systems, CLI tools, and networking workflows.</li>
                    <li>Optimized deployment workflows for neural network quantization, toolchains, and system performance.</li>
                    <li>Adapted and improved neural-network and LLM-based models for deployment on hardware-specific SoCs.</li>
                    <li>Collaborated on demos, documentation, and mentoring initiatives.</li>
                </ul>
            </article>


            <!-- Working Student -->
            <article class="experience-item">
                <div class="experience-header">
                    <div>
                        <h3>Bosch Engineering Center: Working Student</h3>
                        <p class="exp-location">Cluj-Napoca, Romania</p>
                    </div>
                    <div class="exp-dates">2022 – 2023</div>
                </div>

                <ul>
                    <li>Developed tools and scripts for communication between vision systems and vehicle gateways via CAN.</li>
                    <li>Gained hands-on experience with debugging, networking, Docker, and system integration workflows.</li>
                </ul>
            </article>
        </section>



        <!-- EDUCATION + PROJECTS -->
        <section class="section">
            <h2 class="section-title">Education & Projects</h2>

            <!-- Education -->
            <article class="experience-item">
                <div class="experience-header">
                    <div>
                        <h3>Technical University of Cluj-Napoca – Faculty ETTI</h3>
                        <p class="exp-location">Cluj-Napoca, Romania</p>
                    </div>
                </div>

                <ul>
                    <li>
                        <strong>Master in Multimedia Technologies (2022 – 2024)</strong><br>
                        Thesis: <em>Deployment of a Vision-Language Model on Embedded SoCs for traffic scene understanding</em>.
                    </li>
                    <li>
                        <strong>Bachelor in Telecommunications Systems (2018 – 2022)</strong><br>
                        Thesis: <em>Intelligent System for Traffic Sign Detection and Recognition</em> (Python, OpenCV).
                    </li>
                </ul>
            </article>


            <!-- Projects -->
            <article class="project-item">
                <h3>Serverless AWS Resume Website</h3>
                <p>
                    Deployed a fully automated resume website using AWS S3, CloudFront, DynamoDB, Lambda, Terraform,
                    and CI/CD pipelines through GitHub Actions and Jenkins.
                    <br>
                    <a href="https://github.com/luciancibu/AWS-resume" target="_blank">(GitHub Repository)</a>
                </p>
            </article>

            <article class="project-item">
                <h3>Selenium Reservation Server (Home Assistant Integration)</h3>
                <p>
                    Automated sports field booking on <strong>calendis.ro</strong> using Selenium + Chromium in Docker,
                    integrated with Home Assistant.
                    <br>
                    <a href="https://github.com/luciancibu/home-assistant-selenium-docker" target="_blank">
                        (GitHub Repository)
                    </a>
                </p>
            </article>
        </section>
    </main>
    <div class="views">
        <p id="view-counter">Loading views...</p>
    </div>

</div>

<script>
async function updateCounter() {
    if (!sessionStorage.getItem("counted")) {

        let response = await fetch("/view");
        let data = await response.text();
        document.getElementById("view-counter").innerHTML = `Views: $${data}`;


        sessionStorage.setItem("counted", "true");

    } else {
        let response = await fetch("/view?read=true");
        let data = await response.text();
        document.getElementById("view-counter").innerHTML = `Views: $${data}`;
    }
}

updateCounter();
</script>


</body>
</html>

EOF

# style.css
cat > /var/www/frontend/style.css << 'EOF'
*,
*::before,
*::after {
    box-sizing: border-box;
}

html,
body {
    margin: 0;
    padding: 0;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI",
    Roboto, Helvetica, Arial, sans-serif;
    background-color: #f3f4f6;
    color: #111827;
}

.page {
    max-width: 900px;
    margin: 2rem auto;
    padding: 2.5rem 2rem;
    background: #ffffff;
    border-radius: 12px;
    box-shadow:
            0 10px 25px rgba(15, 23, 42, 0.08),
            0 1px 3px rgba(15, 23, 42, 0.1);
}

.header {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: space-between;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 1.5rem;
    margin-bottom: 1.5rem;
}

.name-title {
    min-width: 260px;
}

.name {
    font-size: 2rem;
    letter-spacing: 0.03em;
    margin: 0;
}

.role {
    margin: 0.25rem 0 0;
    font-size: 0.95rem;
    color: #4b5563;
}

.contact {
    display: grid;
    grid-template-columns: 1fr;
    gap: 0.35rem;
    font-size: 0.9rem;
}

.contact-item {
    display: flex;
    gap: 0.35rem;
    align-items: baseline;
}

.contact-label {
    font-weight: 600;
    color: #6b7280;
    min-width: 70px;
}

.contact a {
    color: #2563eb;
    text-decoration: none;
}

.contact a:hover {
    text-decoration: underline;
}

.section {
    margin-bottom: 1.75rem;
}

.section-title {
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 0.18em;
    color: #6b7280;
    margin: 0 0 0.75rem;
    padding-bottom: 0.4rem;
    border-bottom: 1px solid #e5e7eb;
}

.section p {
    margin: 0.2rem 0 0.5rem;
    line-height: 1.5;
    font-size: 0.95rem;
    color: #111827;
}

.section ul {
    margin: 0.2rem 0 0.5rem 1.2rem;
    padding: 0;
    font-size: 0.95rem;
    color: #111827;
}

.section li {
    margin-bottom: 0.25rem;
}

.skills-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
    margin-top: 0.5rem;
}

.skill-block h3 {
    font-size: 0.95rem;
    margin: 0 0 0.35rem;
    color: #374151;
}

.skill-block ul {
    margin-left: 1rem;
}

.experience-item,
.project-item {
    margin-top: 0.9rem;
}

.experience-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    gap: 0.75rem;
}

.experience-header h3 {
    margin: 0;
    font-size: 1rem;
}

.exp-location {
    margin: 0.15rem 0 0;
    font-size: 0.85rem;
    color: #6b7280;
}

.exp-dates {
    font-size: 0.85rem;
    color: #4b5563;
    white-space: nowrap;
}

.project-item h3 {
    margin: 0 0 0.2rem;
    font-size: 0.98rem;
}

.project-item p {
    margin: 0;
}

.footer {
    border-top: 1px solid #e5e7eb;
    margin-top: 2rem;
    padding-top: 0.75rem;
    text-align: center;
    font-size: 0.8rem;
    color: #6b7280;
}

@media (max-width: 640px) {
    .page {
        margin: 1rem;
        padding: 1.5rem 1.25rem;
    }

    .header {
        flex-direction: column;
        align-items: flex-start;
    }

    .experience-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .exp-dates {
        margin-top: 0.15rem;
    }
    .info-button {
        display: inline-block;
        margin: 20px;
        padding: 10px 18px;
        background: #38bdf8;
        color: #0f172a;
        text-decoration: none;
        border-radius: 6px;
        font-weight: bold;
    }

    .info-button:hover {
        background: #0ea5e9;
    }

}

EOF

cat > /etc/nginx/conf.d/frontend.conf << EOF
server {
    listen 80;
    server_name _;

    root /var/www/frontend;
    index index.html;

    # -------- Static frontend --------
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

systemctl enable nginx
systemctl restart nginx
