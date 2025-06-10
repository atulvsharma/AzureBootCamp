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
terraform init -backend=false -reconfigure #As backend is not configured yet. That ensures Terraform ignores the backend block during this phase.

terraform apply -var-file="../${env}.tfvars" -auto-approve

echo "Terraform backend resources provisioned successfully for environment: $env"