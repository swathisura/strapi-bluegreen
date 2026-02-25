# Strapi Blue/Green Deployment on AWS ECS

A Strapi app deployed on AWS ECS Fargate using Blue/Green deployment strategy, managed with Terraform modules and automated via GitHub Actions.

---

## What This Does

Every time you push code to GitHub, the pipeline automatically builds a Docker image, pushes it to ECR, and deploys it to ECS using Blue/Green — meaning zero downtime. If deployment fails, it auto-rolls back.

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Terraform | Create AWS infrastructure |
| AWS ECS Fargate | Run Strapi containers |
| AWS ECR | Store Docker images |
| AWS ALB | Route traffic (Blue/Green) |
| AWS CodeDeploy | Handle Blue/Green switching |
| GitHub Actions | CI/CD pipeline |

---

## Project Structure


strapi-bluegreen/
├── .github/workflows/deploy.yml   # CI/CD pipeline
├── environments/
│   ├── dev/                       # Dev environment config
│   └── prod/                      # Prod environment config
├── modules/
│   ├── alb/                       # Load balancer
│   ├── ecs/                       # ECS cluster + service
│   ├── ecr/                       # Docker registry
│   ├── codedeploy/                # Blue/Green logic
│   ├── iam/                       # Roles & permissions
│   ├── rds/                       # Database
│   └── vpc/                       # Networking
├── strapi-app/                    # Strapi application code
├── appspec.yml                    # CodeDeploy config
└── taskdef.json                   # ECS task blueprint

---

## How to Deploy

**1. Prerequisites**
- AWS CLI configured
- Terraform installed
- Docker installed

**2. Create Infrastructure**
cd environments/dev
terraform init
terraform apply

**3. Push Code → Auto Deploys**

git push origin main


GitHub Actions handles everything from here.

---

## How Blue/Green Works

Push code → Build Docker image → Push to ECR
    → CodeDeploy creates Green environment
    → Health checks pass
    → Traffic switches Blue → Green
    → Old Blue tasks deleted ✅

If anything fails → auto rollback to Blue.

---

## AWS Resources Created

- ECS Cluster + Service (Fargate)
- ECR Repository
- ALB + Blue/Green Target Groups
- CodeDeploy App + Deployment Group
- Security Groups
- IAM Roles

---

## Useful Commands

# Check ECS service
aws ecs describe-services --cluster swathi-dev-cluster --services swathi-dev-service --region us-east-1

# Check deployments
aws deploy list-deployments --application-name swathi-dev-codedeploy --region us-east-1

# Destroy everything
cd environments/dev
terraform destroy


---


