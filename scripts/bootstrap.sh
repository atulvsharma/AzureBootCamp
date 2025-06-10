#!/bin/bash
set -e

export ARM_CLIENT_ID="${AZURE_CLIENT_ID}"
export ARM_CLIENT_SECRET="${AZURE_CLIENT_SECRET}"
export ARM_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID}"
export ARM_TENANT_ID="${AZURE_TENANT_ID}"


if [ -z "$1" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

ENV=$1

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TF_DIR="$ROOT_DIR/terraform-manifests/backend"

echo "Provisioning Terraform backend resources for environment: $ENV"
cd "$TF_DIR"

echo "Current directory: $(pwd)"

terraform init
terraform apply -var="environment=$ENV" -var="location=${LOCATION:-eastus}" -auto-approve
