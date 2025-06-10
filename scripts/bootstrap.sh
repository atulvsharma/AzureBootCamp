#!/bin/bash
set -e

env=$1
echo "Provisioning Terraform backend resources for environment: $env"
cd terraform-manifests/backend

export ARM_CLIENT_ID=${AZURE_CLIENT_ID}
export ARM_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
export ARM_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
export ARM_TENANT_ID=${AZURE_TENANT_ID}

echo "Current directory: $(pwd)"
#terraform init
terraform init \
  -backend-config="resource_group_name=rg-dev-tfstate" \
  -backend-config="storage_account_name=stdevtfstate001" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.tfstate"
echo "Terraform initialized successfully with backend configuration."

terraform apply -var-file="../${env}.tfvars" -auto-approve
echo "Terraform backend resources provisioned successfully for environment: $env"