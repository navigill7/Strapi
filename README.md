# 🚀 Strapi CMS Blue/Green Deployment on AWS (Terraform + GitHub Actions)

This project automates the **CI/CD pipeline for Strapi CMS** with a **Blue/Green deployment strategy** using:

- **Terraform** for provisioning infrastructure
- **GitHub Actions** for automation and deployment
- **Amazon ECS (Fargate)** for running Strapi containers
- **CodeDeploy** for traffic shifting between environments

---

## 🧩 Architecture Overview

![image](https://github.com/user-attachments/assets/d0b5178d-cc91-4773-bd64-7fd58622982c)

---

## 🛠️ Prerequisites

### ✅ AWS Resources You Must Set Up:

- **S3 Bucket**: Used by CodeDeploy to store the AppSpec file.
  - Name your bucket (e.g., `strapi-codedeploy-bucket752`)
  - Make sure it's in the same region as your deployment.
  - Update the S3 bucket name:
    - In the Lambda file: `Deployment_infra/Lambda/main.py`
    - In `.github/workflows/build_and_push.yml` → `S3_BUCKET` env

- **Terraform Cloud Account**:
  - Create a workspace
  - Add your Terraform Cloud API token to GitHub secrets

---

## 🔐 Required GitHub Repository Secrets

| Secret Name                     | Purpose                                  |
|-------------------------------|------------------------------------------|
| `AWS_ACCESS_KEY_ID`           | IAM access key with ECS, S3, CodeDeploy  |
| `AWS_SECRET_ACCESS_KEY`       | IAM secret key                           |
| `AWS_REGION`                  | AWS region (e.g., `ap-south-1`)          |
| `DOCKERHUB_USERNAME`          | Optional – for DockerHub login           |
| `DOCKERHUB_PASSWORD`          | Optional – for DockerHub login           |
| `DOCKERHUB_REPOSITORY`        | Optional – for DockerHub repo            |
| `SSH_PRIVATE_KEY`             | GitHub Actions SSH push support          |
| `TF_API_TOKEN`                | Terraform Cloud API token                |
| `TF_CLOUD_TOKEN_APP_TERRAFORM_IO` | Terraform CLI auth to cloud backend  |

---

## 🔄 Deployment Flow

1. **Developer pushes code** to `main` branch.
2. **GitHub Actions**:
   - Builds Docker image and pushes it to **Amazon ECR** with `sha` tag
   - Updates ECS Task Definition with the new image
   - Commits and pushes the updated `.tf` file
3. **Terraform Apply**:
   - Registers a **new Task Definition revision**
   - Outputs the **latest ARN**
4. **GitHub Actions**:
   - Generates a new **AppSpec** file with that ARN
   - Uploads AppSpec to **S3**
   - Triggers a **CodeDeploy** deployment

---

## 🧪 Cost Optimization

A **Lambda function** is deployed in a private subnet to:
- Remove stale ECS tasks
- Clean orphan ENIs and services

---

## 📁 Project Structure

```bash
Deployment_infra/
├── ECS/
│   ├── service_file.tf
│   └── task_definition.tf
├── CodeDeploy/
│   └── main.tf
├── Lambda/
│   └── main.py (Update bucket name here)
├── variables.tf
└── main.tf
.github/
└── workflows/
    └── build_and_push.yml (Update S3_BUCKET and ECR repo)


```

# TO DEPLOY


# 1. Clone this repository
git clone https://github.com/navigill7/Strapi.git
cd Strapi

# 2. Create the S3 bucket manually via AWS Console or CLI
aws s3 mb s3://strapi-codedeploy-bucket752

# 3. Set the S3 bucket name inside:
# - Deployment_infra/Lambda/main.py
# - .github/workflows/build_and_push.yml

# 4. Push your changes to the `main` branch
git add .
git commit -m "Initial commit"
git push origin main





