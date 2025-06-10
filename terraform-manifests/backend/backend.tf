variable "environment" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = azurerm_resource_group.rg.name
    storage_account_name = azurerm_storage_account.storage.name
    container_name       = azurerm_storage_container.container.name
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  resource_group_name  = "rg-${var.environment}-tfstate"
  storage_account_name = "st${var.environment}tfstate001"
  container_name       = "tfstate"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = local.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
