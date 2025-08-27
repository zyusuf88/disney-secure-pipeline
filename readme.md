# Disney Secure Delivery

**Disney Secure Delivery** is a production-ready, containerised application deployed securely on AWS.

The base application was cloned from [hollyabrams/capstone-project-1](https://github.com/hollyabrams/capstone-project-1) and re-engineered to run as a **cloud-native service** using Docker, ECS Fargate, and Terraform. It leverages **CI/CD automation, strong security controls, and scalable AWS infrastructure**.

The backend uses **Amazon DynamoDB** for persistence. The application is fronted by an **Application Load Balancer (ALB)**, protected with **AWS WAF**, and routed via **Route53**. Infrastructure is managed with **Terraform modules**, and all deployments run through **GitHub Actions workflows** with OIDC authentication.

---

## Demo
*(Insert your app GIF here for instant impact)*# Disney Secure Delivery 🎬🔐

---

## Project breakdown

```bash
.
├── app/
│   ├── app.py, dockerfile, requirements.txt
│   ├── forms.py, models.py, seed.py, db-schema.sql
│   ├── templates/
│   └── static/
│
├── terraform/
│   ├── backend.tf, main.tf, provider.tf
│   ├── variables.tf, outputs.tf, terraform.tfvars
│   ├── env/
│   │   ├── dev.tfvars    # dev environment (not committed)
│   │   └── prod.tfvars   # prod environment (not committed)
│   └── modules/          # vpc, ecs, alb, waf, iam, route53, security, acm
│
└── .github/workflows/
    ├── build-and-push-to-ecr.yml
    ├── terraform-plan.yml
    ├── terraform-apply.yml
    └── terraform-destroy.yml

```


## Architecture at a Glance
*(Pop your architecture diagram here)*

- **Flask backend** containerised via Docker
- **AWS ECS (Fargate)** handling deployment
- **ALB** with redirect from HTTP → secure HTTPS (via ACM certificate)
- **WAF** shields the app with AWS-managed rules
- Data persists in **DynamoDB**
- DNS handled via **Route 53**
- Access logs land in **S3**, metrics in **CloudWatch**
- All wired up using modular Terraform for clean reusability

---

## Highlights

- **Dockerised** with a slim Python 3.12 base
- Infrastructure defined via Terraform modules—flexible, reusable
- Secure CI/CD using **GitHub Actions + OIDC**, no long-lived credentials
- Key AWS components: ALB, WAF, VPC, DynamoDB, Route53, IAM roles, CloudWatch logs & metrics
- Terraform plan reveals the creation of: VPC, public subnets, Internet Gateway, ALB (with HTTP redirect), HTTPS listener, target group, WAF ACL, ECS service & task definition, Route 53 record, S3 bucket (ALB logs), IAM roles, and security groups tagged cleanly
---

## Architecture at a Glance
*(Pop your architecture diagram here)*

- **Flask backend** containerised via Docker
- **AWS ECS (Fargate)** handling deployment
- **ALB** with redirect from HTTP → secure HTTPS (via ACM certificate)
- **WAF** shields the app with AWS-managed rules
- Data persists in **DynamoDB**
- DNS handled via **Route 53**
- Access logs land in **S3**, metrics in **CloudWatch**
- All wired up using modular Terraform for clean reusability

---

## Highlights (No Exhaustive Lists—Just the Good Stuff)

- **Dockerised** with a slim Python 3.12 base
- Infrastructure defined via Terraform modules—flexible, reusable
- Secure CI/CD using **GitHub Actions + OIDC**, no long-lived credentials
- Key AWS components: ALB, WAF, VPC, DynamoDB, Route53, IAM roles, CloudWatch logs & metrics
- Terraform plan reveals the creation of: VPC, public subnets, Internet Gateway, ALB (with HTTP redirect), HTTPS listener, target group, WAF ACL, ECS service & task definition, Route 53 record, S3 bucket (ALB logs), IAM roles, and security groups tagged cleanly

---

## Project Tree (Condensed Version)
