
# 🚀 Strapi CMS Deployment on AWS ECS using Terraform

This project automates the secure, scalable, and cost-optimized deployment of a Strapi CMS backend on AWS using ECS Fargate with Terraform.

---

## 📦 Features

- 📌 **Strapi deployed on ECS Fargate** (On-Demand + Spot capacity providers)
- 🔒 Private Subnet configuration for enhanced security
- 🔁 Auto-scalable, load-balanced infrastructure using ALB
- 📉 Cost optimization via scheduled ECS cleanup using Lambda + CloudWatch
- 🧠 CloudWatch monitoring and threshold-based alerts
- 🔐 IAM roles and security groups managed via Terraform
- ✅ Fully modular and reproducible infrastructure-as-code setup

---

## 🗂️ Folder Structure

Deployment_infra/
├── Networking/ # VPC, Subnets, NAT Gateway, Route Tables
├── Security/ # Security groups and rules
├── ECS/ # Task definition, ECS cluster, ECS service
├── IAM/ # IAM roles and policies for ECS and Lambda
├── Lambda/ # Cleanup Lambda + trigger config
├── cloudwatch/ # Monitoring & alarms
├── main.tf # Module composition
├── variables.tf # Input variables
└── output.tf # Useful outputs (e.g., ALB DNS)


---

## 🧱 Infrastructure Overview

- **Strapi App** runs inside a container on **ECS Fargate**
- ECS Tasks are deployed inside **private subnets**
- **Application Load Balancer (ALB)** sits in public subnets for traffic routing
- **NAT Gateway** enables internet access for private tasks (for pulling Docker images)
- **Lambda Function** scheduled via **CloudWatch Events** performs cleanup of:
  - Stopped ECS tasks
  - Unused services
  - Available ENIs
- **CloudWatch Alarms** trigger alerts for high CPU/memory usage

---

## ✅ Prerequisites

- AWS CLI configured
- Terraform v1.4+
- Docker (for building Strapi image)
- AWS credentials set via environment or profile

---

## ⚙️ How to Use

1. **Clone the repo:**

```bash
git clone https://github.com/navigill7/Strapi.git
cd Strapi/Deployment_infra
cd ../strapi
docker build -t <your-dockerhub-username>/strapi:<tag> .
docker push <your-dockerhub-username>/strapi:<tag>
bash

2 Update task definition image tag in ECS module

3 Deploy infrastructure:

```bash
cd ../Deployment_infra
terraform init
terraform apply -auto-approve
bash

🔁 ECS Cleanup Lambda (Optional)
This project includes a Lambda function that deletes unused ECS resources:

Runs daily via CloudWatch Event Rule

Logs to CloudWatch Logs

Written in Python and zipped before deployment via Terraform

🔗 Useful Links
Strapi CMS

Terraform AWS Provider Docs

AWS Fargate

👨‍💻 Maintainer
Navinder Gill
GitHub: @navigill7



