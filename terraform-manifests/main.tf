provider "azurerm" {
  features {}
}

module "network" {
  source              = "./terraform-manifests/network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "vnet-dev"
  vnet_address_space  = ["10.0.0.0/16"]
}

module "compute" {
  source                = "./terraform-manifests/compute"
  resource_group_name   = var.resource_group_name
  location              = var.location
  subnet_id             = module.network.web_subnet_id
  ssh_public_key_path   = var.ssh_public_key_path
  admin_username        = var.admin_username
}

module "lb" {
  source              = "./terraform-manifests/lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  public_ip_id        = module.compute.web_ip_id
}

module "bastion" {
  source                = "./terraform-manifests/bastion"
  resource_group_name   = var.resource_group_name
  location              = var.location
  bastion_subnet_id     = module.network.bastion_subnet_id
  bastion_public_ip_id  = module.compute.bastion_ip_id
}