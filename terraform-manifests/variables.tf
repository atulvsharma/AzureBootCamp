variable "business_divsion" {
  description = "This is the business division for the deployment - inst-it"
  type        = string
}

variable "resource_group_location" {
  description = "The Azure region where the resource group will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group to create"
  type        = string
}


#variable "environment" {
#  description = "The deployment environment name (dev, qa, prod, stage)"
#  type        = string
#}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
}