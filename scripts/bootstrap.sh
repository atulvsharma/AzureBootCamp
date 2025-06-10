#!/bin/bash
set -e

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
