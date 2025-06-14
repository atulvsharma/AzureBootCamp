#!/bin/bash
# deploy.sh: Deploys application infrastructure using Terraform

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./deploy.sh <environment>"
  exit 1
fi

TFVARS_FILE="${ENV}.tfvars"

if [ ! -f "terraform-manifests/$TFVARS_FILE" ]; then
  echo "Terraform vars file terraform-manifests/$TFVARS_FILE not found"
  exit 1
fi

cd terraform-manifests || exit

terraform init -backend-config=env/${ENV}.env -reconfigure
terraform apply -auto-approve -var-file="${TFVARS_FILE}"
