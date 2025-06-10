#!/bin/bash
set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TF_DIR="$ROOT_DIR/terraform-manifests"

echo "Root directory: $ROOT_DIR"
echo "Terraform directory: $TF_DIR"
echo "Initializing Terraform backend for all environments..."

for env in dev qa prod stage; do
  echo "Applying Terraform backend for $env"

  cd "$TF_DIR"
  echo "Current directory: $(pwd)"
  echo "Looking for: $TF_DIR/$env.tfvars"

  #terraform init -backend-config=backend.tfvars
  terraform init
  terraform apply -var-file="$TF_DIR/$env.tfvars" -auto-approve
done
