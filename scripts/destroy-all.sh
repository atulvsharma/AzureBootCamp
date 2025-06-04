#!/bin/bash
set -e

# Export environment variables for Terraform authentication
export ARM_CLIENT_ID=$AZURE_CLIENT_ID
export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET
export ARM_TENANT_ID=$AZURE_TENANT_ID
export ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID

# Log in
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
az account set --subscription $AZURE_SUBSCRIPTION_ID

# Destroy Terraform-managed infrastructure
terraform -chdir=terraform init
terraform -chdir=terraform destroy -auto-approve

# Delete storage container
az storage container delete --name $CONTAINER_NAME --account-name $BACKEND_STORAGE  --auth-mode login --yes

# Delete storage account
az storage account delete --name $BACKEND_STORAGE --resource-group $BACKEND_RG --yes

# Delete resource group
az group delete --name $BACKEND_RG --yes --no-wait
