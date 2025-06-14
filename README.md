# Terraform Azure Infrastructure Project

This repository defines an **Infrastructure as Code (IaC)** approach for provisioning and managing **Azure resources** using **Terraform** and **GitHub Actions**. The project separates backend provisioning (for the Terraform state) from application infrastructure provisioning, supports multiple environments, and automates deployment using CI/CD pipelines.

---

## Overview

This repository demonstrates the following:

1. Create backend resources to hold the state files for **dev**, **qa**, **staging**, and **prod** environments.
2. Backend resources can be provisioned by selecting the appropriate region from the **GitHub Actions workflow** dropdown.
3. These resources can also be destroyed by manually running the **destroy-infra** workflow from GitHub Actions.

---

## 📁 Folder Structure

```
AzureBootCamp/
├── .github/workflows/
│   └── deploy.yml               # GitHub Actions workflow for deployment
├── env/
│   └── dev.env                  # Environment-specific variables (LOCATION, etc.)
├── scripts/
│   └── bootstrap.sh            # Script to bootstrap Terraform backend infrastructure
├── terraform-manifests/
│   ├── backend/
│   │   ├── backend.tf          # Terraform code for backend (storage account, container)
│   │   └── variables.tf        # Input variables for backend.tf
│   ├── dev.tfvars              # Environment-specific Terraform variables
│   └── main.tf                 # Main Terraform configuration for application infrastructure
```

---

## 🔑 Key Components

### 1. `bootstrap.sh`
- Shell script to provision backend resources:
  - Azure Resource Group
  - Storage Account
  - Blob Container
- Executes `terraform init` and `terraform apply` in `terraform-manifests/backend/`.
- Uses environment variables like `TF_ENV`, `LOCATION`, `BACKEND_RG`, etc.

---

### 2. `deploy.yml`
- GitHub Actions CI/CD workflow:
  - Detects the environment from branch name or input.
  - Loads relevant environment variables.
  - Sets up and initializes Terraform backend.
  - Applies infrastructure in `main.tf`.

---

### 3. `backend.tf` & `variables.tf` (in `terraform-manifests/backend/`)
- Define backend infrastructure:
  - Azure Resource Group
  - Azure Storage Account
  - Azure Blob Container

---

### 4. `main.tf`
- Core Terraform configuration for your Azure application infrastructure:
  - VMs, NSGs, Subnets, etc.

---

### 5. `dev.tfvars`
- Contains environment-specific variables for Terraform.
- Passed using `-var-file` during Terraform apply.

---

### 6. `env/dev.env`
- Environment variable file example:
  ```env
  LOCATION=eastus
  BACKEND_RG=rg-dev-tfstate
  BACKEND_STORAGE=stdevtfstate001
  CONTAINER_NAME=tfstate
  ```

---

## 🚀 Usage Instructions

### ✅ Bootstrap Backend
```bash
./scripts/bootstrap.sh dev
```

### 🚀 Deploy via GitHub Actions
- Push changes to the appropriate environment branch (`dev`, `qa`, `staging`, `prod`).
- Or dispatch the workflow manually from the GitHub Actions UI with the desired environment.

---

## ⚙️ Notes

- `terraform init` must use `-backend-config` with dynamically set parameters.
- Secrets like `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, etc., must be configured in GitHub repository secrets.

---

## 🛠 Troubleshooting

- **Missing config files error**: Ensure you're in the correct working directory (`terraform-manifests/backend` or `terraform-manifests`).
- **Backend init required**: Run `terraform init -reconfigure` after any changes to backend config.
- **Directory not found**: Ensure relative paths in `bootstrap.sh` and `deploy.yml` are accurate.

---

## 🔮 Next Steps

- Add Terraform modules to `main.tf` for app-specific infrastructure.
- Extend to other environments like **qa** and **prod**.
- Configure Terraform outputs and state locking if needed.