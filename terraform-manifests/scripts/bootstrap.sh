#!/bin/bash
# bootstrap.sh: Initializes backend infrastructure for a specific environment

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./bootstrap.sh <environment>"
  exit 1
fi

ENV_FILE="env/${ENV}.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Environment file $ENV_FILE does not exist."
  exit 1
fi

echo "Sourcing environment variables from $ENV_FILE"
set -o allexport
source "$ENV_FILE"
set +o allexport

cd terraform-manifests/backend || exit

echo "Initializing backend for environment: $ENV"
terraform init -reconfigure
terraform apply -auto-approve
