variable "resource_group_name" {}

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