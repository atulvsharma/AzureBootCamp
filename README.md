# Terraform Azure Infrastructure Project

This repository defines a **multi-tier Infrastructure as Code (IaC)** solution for deploying and managing Azure resources using **Terraform** and **GitHub Actions**.

It supports:
- Multiple environments (`dev`, `qa`, `prod`)
- Modular backend provisioning for Terraform state
- Automated deployments with CI/CD
- A Linux VM running Apache Tomcat behind a Standard Load Balancer
- A Bastion Host for secure access
- NSGs, VNet, subnets, and version locking via `.terraform.lock.hcl`

---

## Folder Structure

```
terraform-manifests/
├── .github/workflows/
│   ├── ci.yml             # Terraform format/validate checks
│   └── deploy.yml         # CI/CD deployment pipeline
├── scripts/
│   ├── bootstrap.sh       # Bootstrap backend infrastructure
│   ├── deploy.sh          # Apply infrastructure per environment
│   └── destroy.sh         # Tear down infrastructure
├── backend/
│   ├── backend.tf         # Storage Account, Container
│   └── variables.tf       # Input variables for backend
├── env/
│   └── dev.env            # Environment-specific backend configs
├── dev.tfvars             # Variables for the 'dev' environment
├── main.tf                # Multi-tier application architecture
└── README.md
```

---

## Environments

Each environment (`dev`, `qa`, `prod`) has:
- Its own state backend (Resource Group + Storage + Container)
- Configs via `.tfvars` and `.env` files

---

## Components

- **VNet + Subnets**: Segmented for web, app, db, and Bastion layers
- **NSGs**: For secure subnet traffic control
- **Load Balancer**: Standard Azure LB for frontend traffic
- **Linux VM**: With Apache Tomcat + HTML page via `custom_data`
- **Bastion Host**: Secure VM management access
- **State Storage**: Configured via backend.tf and environment .env files

---

## Usage Instructions

### 1. Bootstrap Backend Infrastructure

```bash
./scripts/bootstrap.sh dev
```

> Make sure your `env/dev.env` has values like:
> ```bash
> LOCATION=eastus
> BACKEND_RG=rg-dev-tfstate
> BACKEND_STORAGE=stdevtfstate001
> CONTAINER_NAME=tfstate
> ```

---

### 2. Deploy Infrastructure via CLI

```bash
./scripts/deploy.sh dev
```

---

### 3. Destroy Infrastructure via CLI

```bash
./scripts/destroy.sh dev
```

---

### 4. Deploy via GitHub Actions

- Go to **Actions > Deploy Infrastructure**
- Select environment: `dev`, `qa`, or `prod`

---

### 5. Destroy via GitHub Actions

- Go to **Actions > Destroy Infrastructure**
- Select environment: `dev`, `qa`, or `prod`

---

## CI/CD Pipelines

### ci.yml
- Runs on `push` and `pull_request`
- Checks formatting (`terraform fmt`)
- Validates config (`terraform validate`)

### deploy.yml
- Runs on workflow_dispatch or push to environment branches
- Bootstraps backend (if needed)
- Applies infrastructure using `terraform apply`

---

## Version Locking

All providers and modules are locked in `.terraform.lock.hcl` for consistency across environments.

---

## Errors and fixes**
- Infinite loop on bootstrap.sh --> Unable to find reqquired backedn resources. Updated the terraform apply 
command as below -

terraform apply -auto-approve \
  -var "resource_group_name=$BACKEND_RG" \
  -var "storage_account_name=$BACKEND_STORAGE" \
  -var "container_name=$CONTAINER_NAME" \
  -var "location=$LOCATION"

---

## Next Steps

- Extend to add app and DB tiers with modules
- Add outputs for DNS names, IPs
- Configure remote state locking with Azure Blob lease
