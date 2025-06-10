terraform {
  required_version = ">= 1.5.7"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

variable "environment" {
  type = string
}
