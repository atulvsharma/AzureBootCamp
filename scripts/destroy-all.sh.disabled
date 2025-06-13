#!/bin/bash
set -e

# Export for Terraform authentication
export ARM_CLIENT_ID="$AZURE_CLIENT_ID"
export ARM_CLIENT_SECRET="$AZURE_CLIENT_SECRET"
export ARM_SUBSCRIPTION_ID="$AZURE_SUBSCRIPTION_ID"
export ARM_TENANT_ID="$AZURE_TENANT_ID"

echo "🔨 Destroying Terraform-managed infrastructure..."
echo "DEBUG: BACKEND_STORAGE=$BACKEND_STORAGE"
echo "DEBUG: TF_ENV=$TF_ENV"

terraform -chdir=terraform-manifests init \
  -backend-config="resource_group_name=${BACKEND_RG}" \
  -backend-config="storage_account_name=${BACKEND_STORAGE}" \
  -backend-config="container_name=${CONTAINER_NAME}" \
  -backend-config="key=${TF_ENV}.tfstate" \
  -backend-config="use_azuread_auth=true"

terraform -chdir=terraform-manifests destroy \
  -var-file="${TF_ENV}.tfvars" \
  -auto-approve

echo "🗑️ Deleting blob container..."
az storage container delete \
  --name "$CONTAINER_NAME" \
  --account-name "$BACKEND_STORAGE" \
  --auth-mode login \
  --output none || true

echo "💥 Deleting storage account..."
az storage account delete \
  --name "$BACKEND_STORAGE" \
  --resource-group "$BACKEND_RG" \
  --yes --output none || true

echo "🏁 Deleting resource group..."
az group delete \
  --name "$BACKEND_RG" \
  --yes \
  --no-wait \
  --output none || true

echo "✅ Cleanup complete."
