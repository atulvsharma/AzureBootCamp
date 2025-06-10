#!/bin/bash
set -e

echo "Provisioning Terraform backend resources for environment: $1"
env=$1

cd terraform-manifests/backend

# Export Azure authentication details
export ARM_CLIENT_ID="${AZURE_CLIENT_ID}"
export ARM_CLIENT_SECRET="${AZURE_CLIENT_SECRET}"
export ARM_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"
export ARM_TENANT_ID="${AZURE_TENANT_ID}"

echo "Current directory: $(pwd)"
echo "Initializing the backend..."

terraform init
terraform apply -var="environment=$ENV" -var="location=${LOCATION:-eastus}" -auto-approve
