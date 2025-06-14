# Terraform Azure Multitier Infrastructure Project

This project provisions a multitier Azure infrastructure using Terraform and GitHub Actions.

## Features

- Multi-environment support (dev, staging, prod)
- Modular Terraform code: network, compute, bastion, and load balancer
- Backend state stored in Azure Storage defined by `env/dev.env`
- Apache Tomcat installed on web VMs via cloud-init
- Bastion Host access to VMs for secure management
- Load Balancer in front of web tier

## Folder Structure

```
.
├── .github/workflows/         # GitHub Actions workflows
├── env/                       # Environment variable files
├── modules/                   # Reusable Terraform modules
│   ├── network/               # VNet, Subnets, NSGs
│   ├── compute/               # VM with Tomcat
│   ├── lb/                    # Standard Load Balancer
│   └── bastion/               # Bastion Host
├── scripts/                   # Bootstrap and helper scripts
├── terraform-manifests/      # Root Terraform config
│   ├── main.tf
│   ├── variables.tf
│   ├── dev.tfvars
│   └── .terraform.lock.hcl
└── README.md
```

## Deployment

### 1. Bootstrap the backend

```bash
./scripts/bootstrap.sh dev
```

### 2. Plan and apply infrastructure

```bash
cd terraform-manifests
terraform init -backend-config=../env/dev.env -reconfigure
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

## Access

- Web app: Access Apache Tomcat using public IP from Load Balancer
- SSH access: via Bastion Host (IP in Azure portal)

## GitHub Actions Workflows

### Manual Deployment

You can manually deploy the infrastructure from the **Actions** tab:

- Navigate to `Terraform Deploy`
- Click **Run workflow**
- Select the environment (`dev`, `qa`, or `prod`)

### Manual Destruction

You can also destroy the infrastructure via the **Actions** tab:

- Navigate to `Terraform Destroy`
- Click **Run workflow**
- Select the environment to destroy### Continuous Integration (CI)

On each push or PR to `main` branch, the following checks run automatically:

- `terraform fmt -check` for formatting consistency
- `terraform validate` to ensure configuration correctness

### Environment-Level Approvals

Use GitHub branch protection and environments for:
- Requiring review before merging to `main`
- Restricting deployment access