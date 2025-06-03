# Azure Bootstrap and Deploy with Terraform and GitHub Actions

This project automates:
- Creation of Azure backend infrastructure (resource group, storage account, container)
- Creation of a service principal with required roles
- Terraform-based provisioning of an Azure Resource Group
- Destroy the resources manually from GitHub
- Destroy the backend resources (resource group, storage account and container) holding the state file.
Note --> destroy-infra.yml workflow will not be listed under Actions --> Workflow untill master branch is switched to 02-Rev-RscGrp-StrAcct-For-TFStFile. This can be done by going in repo AzureBootCamp --> Settings --> Default branch --> Switch the master branch to 02-Rev-RscGrp-StrAcct-For-TFStFile