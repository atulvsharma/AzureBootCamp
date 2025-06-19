resource "azurerm_linux_virtual_machine" "web" {
  name                  = "web-vm"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]
  custom_data           = base64encode(file("${path.module}/customdata.sh"))
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "web-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_ip.id
  }
}

resource "azurerm_public_ip" "web_ip" {
  name                = "web-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}