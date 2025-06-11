# This repo demonstrates to below actions 
1. Create the backend resources to hold the statefiles for dev, qa, staging and prod regions
2. Backend resources can be provisioned by selecting the respective region from the run workflow dropdown
3. These resources can be destroyed by running the detroy-infra workflow manually from Git Actions 

Terraform Azure Infrastructure Project

This repository defines an Infrastructure as Code (IaC) approach for provisioning and managing Azure resources using Terraform and GitHub Actions. The project separates backend provisioning (for the Terraform state) from application infrastructure provisioning, supports multiple environments, and automates deployment using CI/CD pipelines.

Folder Structure

AzureBootCamp/
├── .github/workflows/
│   └── deploy.yml               # GitHub Actions workflow for deployment
├── env/
│   └── dev.env                  # Environment-specific variables (LOCATION, etc.)
├── scripts/
│   └── bootstrap.sh            # Shell script to bootstrap Terraform backend infrastructure
├── terraform-manifests/
│   ├── backend/
│   │   ├── backend.tf          # Terraform code for backend infrastructure (storage account, container)
│   │   └── variables.tf        # Input variables for backend.tf
│   ├── dev.tfvars              # Environment-specific Terraform variables
│   └── main.tf                 # Main Terraform configuration for application infrastructure

Key Components

1. bootstrap.sh

Shell script responsible for provisioning backend resources (Resource Group, Storage Account, Blob Container) to host the Terraform state file.

It runs terraform init and terraform apply inside the terraform-manifests/backend directory.

It uses environment variables such as TF_ENV, LOCATION, BACKEND_RG, etc.

2. deploy.yml

GitHub Actions workflow that:

Detects the environment from the branch name or workflow input.

Loads environment-specific variables.

Sets up Terraform.

Bootstraps backend if not already available.

Initializes Terraform with the backend configuration.

Applies the infrastructure defined in main.tf.

3. backend.tf and variables.tf (in terraform-manifests/backend/)

Defines the resources required to support Terraform backend state storage, including:

Azure Resource Group

Azure Storage Account

Azure Blob Container

4. main.tf

Holds your actual Azure infrastructure configuration (e.g., VMs, NSGs, subnets, etc.) for your application tiers.

5. dev.tfvars

Environment-specific configuration passed using -var-file during Terraform apply.

6. env/dev.env

Sets shell environment variables such as:

LOCATION=eastus
BACKEND_RG=rg-dev-tfstate
BACKEND_STORAGE=stdevtfstate001
CONTAINER_NAME=tfstate

Usage Instructions

Bootstrap Backend

./scripts/bootstrap.sh dev

Deploy via GitHub Actions

Push changes to the appropriate environment branch (e.g., dev, qa, staging, prod).

Or manually dispatch the workflow from the GitHub Actions UI with the desired environment.

Notes

The terraform init step for terraform-manifests/ must use -backend-config with dynamically set parameters.

Secrets like AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, etc., must be configured in the GitHub repository secrets.

Troubleshooting

Missing config files error: Ensure you run terraform from the correct directory (terraform-manifests/backend or terraform-manifests).

Backend init required: Always run terraform init -reconfigure after changes to backend config.

Directory not found: Use correct relative paths in bootstrap.sh and deploy.yml.

Next Steps

Add modules to main.tf for application-specific infrastructure.

Extend to other environments (e.g., qa, prod).

Configure outputs and state locking as needed.