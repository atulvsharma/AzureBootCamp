#!/bin/bash
set -e

# Log in
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
az account set --subscription $AZURE_SUBSCRIPTION_ID

# Destroy Terraform-managed infrastructure
terraform -chdir=terraform init
terraform -chdir=terraform destroy -auto-approve

# Delete storage container
az storage container delete --name $CONTAINER_NAME --account-name $BACKEND_STORAGE --yes

# Delete storage account
az storage account delete --name $BACKEND_STORAGE --resource-group $BACKEND_RG --yes

# Delete resource group
az group delete --name $BACKEND_RG --yes --no-wait
