provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
<<<<<<< HEAD
    storage_account_name = "yourstorageacct"
=======
    storage_account_name = "devtfstorageacct"
>>>>>>> 071a9d8bb3de5969465e7ca518af0e3827386380
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

<<<<<<< HEAD
resource "azurerm_resource_group" "example" {
=======
resource "azurerm_resource_group" "rgp_name" {
>>>>>>> 071a9d8bb3de5969465e7ca518af0e3827386380
  name     = var.rg_name
  location = var.location
}
