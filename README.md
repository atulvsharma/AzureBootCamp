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
│   └── deploy.yml              # GitHub Actions workflow for deployment
├── env/
│   └── dev.env                 # Environment-specific variables (LOCATION, etc.)
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
  - Applies infrastructure in `main.tf`. For this repo, we are not configuring anyother resource other than    
    backend resources.

---

### 3. `backend.tf` & `variables.tf` (in `terraform-manifests/backend/`)
- Define backend infrastructure:
  - Azure Resource Group
  - Azure Storage Account
  - Azure Blob Container

---

### 4. `main.tf`
- Terraform configuration can be enhanced further to provision Azure resource like:
  - VMs, NSGs, Subnets, etc.

---

### 5. `dev.tfvars`
- Contains environment-specific variables for Terraform.
- Passed using `-var-file` during Terraform apply.

---

### 6. `env/dev.env`
- Dev environment variable file is as below. Other qa.env, staging.env and prod.env files can also be found at 
  this location. 
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
- **Adding executable permissions to scripts**: Run the below git commands locally on Git bash to add executable 
   permissions.
- **Service Principle related issues** Run az ad sp create-for-rbac --name "github-terraform" --role="Contributor" 
  --scopes="/subscriptions/<Your subscription ID>" --sdk-auth
-    a. Go to Subscriptions > Your Subscription
-    b. Click “Access control (IAM)”
-    c. Click “+ Add” → “Add role assignment”
-    d. Choose Role: Contributor
-    e. In Assign access to: Select User, group, or service principal
-    f. Click Select members, then search for your app name "github-terraform"
-    g. Click Review + assign
- **ssh key creation** Run the below command to create the ssh key 
-    Gernerate the ssh keys under folder ssh-keys using command -
-    ssh-keygen -m PEM -t rsa -b 4096 -C "azureuser@myserver" -f terraform-azure.pem  
-    chmod 400 terraform-azure.pem


---

## 🔮 Next Steps

- Add Terraform modules to `main.tf` for app-specific infrastructure.
- Configure Terraform outputs and state locking if needed.