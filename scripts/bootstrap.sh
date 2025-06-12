#!/bin/bash
set -e

env=$1
echo "Provisioning Terraform backend resources for environment: $env"
cd terraform-manifests/backend

export ARM_CLIENT_ID=${AZURE_CLIENT_ID}
export ARM_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
export ARM_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
export ARM_TENANT_ID=${AZURE_TENANT_ID}

# TEMPORARILY rename backend config to avoid triggering backend block
#mv backend.tf backend.tf.disabled

echo "Current directory: $(pwd)"
#terraform init -backend=false #As backend is not configured yet. That ensures Terraform ignores the backend block during this phase.
terraform init

terraform apply -auto-approve \
  -var="resource_group_name=$BACKEND_RG" \
  -var="location=$LOCATION" \
  -var="storage_account_name=$BACKEND_STORAGE" \
  -var="container_name=$CONTAINER_NAME"


# Rename backend config back
#mv backend.tf.disabled backend.tf

echo "Terraform backend resources provisioned successfully for environment: $env"