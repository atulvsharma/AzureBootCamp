resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_name            = "mybastionhostdns"
  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = var.bastion_public_ip_id
  }
}