# Azure Resource Group with Terraform and GitHub Actions

This project demonstrates how to use GitHub Actions and PowerShell to deploy an Azure Resource Group using Terraform and store the state in an Azure Storage Account.

I used below commands to create the backend resources
az group create --name tfstate-rg --location eastus
az storage account create --name devtfstorageacct --resource-group tfstate-rg --sku Standard_LRS
az storage container create --name tfstate --account-name devtfstorageacct

I used below command to create service pronciple 
az ad sp create-for-rbac --name "github-terraform" --sdk-auth

This will give give the required details in the below JSON format -

{
  "clientId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
  "clientSecret": "YOUR_SECRET_VALUE",
  "subscriptionId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
  "tenantId": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
  ...
}


