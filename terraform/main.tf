provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "devtfstorageacct"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rgp_name" {
  name     = var.rg_name
  location = var.location
}
