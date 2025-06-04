# Azure Bootstrap and Deploy with Terraform and GitHub Actions

This project automates:
- Creation of Azure backend infrastructure (resource group, storage account, container)
- Creation of a service principal with required roles
- Terraform-based provisioning of an Azure Resource Group
- Destroy the resources manually from GitHub
- Destroy the backend resources (resource group, storage account and container) holding the state file.

Notes 
1. destroy-infra.yml workflow will not be listed under Actions --> Workflow untill master branch is      switched to 02-Rev-RscGrp-StrAcct-For-TFStFile. This can be done by going in repo AzureBootCamp --> Settings --> Default branch --> Switch the master branch to 02-Rev-RscGrp-StrAcct-For-TFStFile

2. Goto Actions --> Under All Workflows --> You will see all the workflows and click on the workflow --> From Run workflow dropdown "Click on the Run WorkFlow"  

Error
1. /home/runner/work/_temp/9c89959e-0a48-4cb4-b88b-4d7477075f63.sh: line 1: ./scripts/destroy-all.sh: Permission denied
Error: Process completed with exit code 126.
 
 Resolution 
1. git update-index --chmod=+x scripts/destroy-all.sh
git commit -m "Make destroy-all.sh executable"
git push