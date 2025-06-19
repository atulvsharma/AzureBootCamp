variable "resource_group_name" {
  type        = string
  description = "Resource group name for the bastion host"
}


variable "ssh_public_key_path" {}
variable "admin_username" {}
variable "env" {
  description = "Deployment environment (dev, qa, etc.)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, qa)"
  type        = string
}

variable "backend_storage" {
  description = "The backend storage account name"
  type        = string
}

variable "bastion_subnet_id" {
  type        = string
  description = "Subnet ID for Bastion"
}

variable "bastion_public_ip_id" {
  type        = string
  description = "Public IP ID for Bastion"
}