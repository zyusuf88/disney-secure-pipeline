# Disney Secure Delivery
[![1) Build and Push to ECR](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/build-and-push-to-ecr.yml/badge.svg)](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/build-and-push-to-ecr.yml) [![2) Terraform Plan with checks](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terrafrom-plan.yml/badge.svg)](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terrafrom-plan.yml) [![3) Terraform Apply](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terrafrom-apply.yml/badge.svg)](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terrafrom-apply.yml) [![4) Terraform Destroy](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terraform-destroy.yml/badge.svg)](https://github.com/zyusuf88/disney-secure-delivery/actions/workflows/terraform-destroy.yml)

**Disney Secure Delivery** is a production-ready, containerised application deployed securely on AWS.

The base application was cloned from [hollyabrams/capstone-project-1](https://github.com/hollyabrams/capstone-project-1) and re-engineered to run as a **cloud-native service** using Docker, ECS Fargate and Terraform. It leverages **CI/CD automation, strong security controls, and scalable AWS infrastructure**.

The backend uses **Amazon DynamoDB** for persistence. The application is fronted by an **Application Load Balancer (ALB)**, protected with **AWS WAF**, and routed via **Route53**. Infrastructure is managed with **Terraform modules**, and all deployments run through **GitHub Actions workflows** with OIDC authentication.

---

## Demo

![Image](https://github.com/user-attachments/assets/f8fbc76c-2256-4655-a0b5-9dbb362e6900)
---

## Architecture
![architecture diagram](./assets/Arch%20diagram.png)

- **Flask backend** containerised via Docker
- **AWS ECS (Fargate)** handling deployment
- **ALB** with redirect from HTTP → secure HTTPS (via ACM certificate)
- **WAF** shields the app with AWS-managed rules
- Data persists in **DynamoDB**
- DNS handled via **Route 53**
- Access logs land in **S3**, metrics in **CloudWatch**
- All wired up using modular Terraform for clean reusability

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
│   │   ├── dev.tfvars    # dev env (not committ
│   │   └── prod.tfvars   # prod env (not committed)
│   └── modules/          # vpc, ecs, alb, waf, iam, route53, security, acm
│
└── .github/workflows/
    ├── build-and-push-to-ecr.yml
    ├── terraform-plan.yml
    ├── terraform-apply.yml
    └── terraform-destroy.yml

```

### Certificate Validation
<img width="1249" height="578" alt="Image" src="https://github.com/user-attachments/assets/c717882f-23e4-409a-9ff3-d486ecf8f38e" />

>  `disney.yzeynab.com` secured with ACM TLS/SSL → HTTPS enforced


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


### Local Development (Dockerised)

Run the application inside a container:

```bash
# Build the Docker image
docker build -t disney-secure-delivery .

# Run the container
docker run -p 5000:5000 disney-secure-delivery
````

The app will be available at http://localhost:5000
.
