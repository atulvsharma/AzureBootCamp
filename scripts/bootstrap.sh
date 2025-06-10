#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

ENV=$1

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TF_DIR="$ROOT_DIR/terraform-manifests"

echo "Root directory: $ROOT_DIR"
echo "Terraform directory: $TF_DIR"
echo "Applying Terraform backend for environment: $ENV"

cd "$TF_DIR"

echo "Current directory: $(pwd)"
echo "Using tfvars file: $ENV.tfvars"

terraform init

terraform apply -var-file="$ENV.tfvars" -auto-approve
