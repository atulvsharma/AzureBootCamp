#!/bin/bash
set -e

ROOT_DIR=$(pwd)
TF_DIR="$ROOT_DIR/terraform-manifests"

echo "Initializing Terraform backend for all environments..."

for env in dev qa prod stage; do
  echo "Applying Terraform backend for $env"
  cd "$TF_DIR"
  #terraform init -backend-config=backend.tfvars
  terraform init
  terraform apply -var-file="$env.tfvars" -auto-approve
done