#!/bin/bash
set -e

echo "Logging into Azure..."
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

echo "Setting subscription..."
az account set --subscription $AZURE_SUBSCRIPTION_ID

echo "Creating backend resource group..."
az group create --name $BACKEND_RG --location $LOCATION

echo "Creating storage account..."
az storage account create --name $BACKEND_STORAGE --resource-group $BACKEND_RG --location $LOCATION --sku Standard_LRS

echo "Creating storage container..."
az storage container create --name $CONTAINER_NAME --account-name $BACKEND_STORAGE

echo "Creating service principal..."
SP_JSON=$(az ad sp create-for-rbac --name github-terraform --role contributor --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID)
SP_APP_ID=$(echo $SP_JSON | jq -r '.appId')
SP_PASSWORD=$(echo $SP_JSON | jq -r '.password')

echo "Assigning Storage Account Key Operator Service Role..."
STORAGE_ID=$(az storage account show --name $BACKEND_STORAGE --resource-group $BACKEND_RG --query "id" -o tsv)
az role assignment create --assignee $SP_APP_ID --role "Storage Account Key Operator Service Role" --scope $STORAGE_ID

echo "::set-output name=client_id::$SP_APP_ID"
echo "::set-output name=client_secret::$SP_PASSWORD"
