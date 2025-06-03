provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "aksdev-tfstate-rg"
    storage_account_name = "aksdevstracct"
    container_name       = "aksdevtfstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}
