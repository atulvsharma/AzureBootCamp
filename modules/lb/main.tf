resource "azurerm_lb" "web_lb" {
  name                = "web-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "public-ip"
    public_ip_address_id = var.public_ip_id
  }
}