This repository contains infrastructure code and automation scripts for deploying a Strapi application using Docker and Terraform. It sets up a production-ready environment on AWS, including EC2 instances, VPC networking, and optionally a bastion host. The deployment pipeline installs Docker, pulls the Strapi Docker image, and runs it with proper configuration.

Key Features:

Infrastructure as Code (Terraform)

Automated Docker setup via EC2 user-data

Supports Strapi running on SQLite or PostgreSQL

Bastion host support for accessing private instances

Ready for CI/CD integration


# INFRASTRUCTURE DIAGRAM 

![image](https://github.com/user-attachments/assets/d0b5178d-cc91-4773-bd64-7fd58622982c)


