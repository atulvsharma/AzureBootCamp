variable "resource_group_name" {
  type        = string
  description = "Resource group name for the bastion host"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "bastion_subnet_id" {
  type        = string
  description = "Subnet ID for Bastion"
}

variable "bastion_public_ip_id" {
  type        = string
  description = "Public IP ID for Bastion"
}
