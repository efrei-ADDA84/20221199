provider "azurerm" {
  features {}
  subscription_id = "765266c6-9a23-4638-af32-dd1e32613047"
  skip_provider_registration = true
}

data "azurerm_virtual_network" "existing" {
  name                = "network-tp4"
  resource_group_name = "ADDA84-CTP"
}

data "azurerm_subnet" "existing" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = data.azurerm_virtual_network.existing.resource_group_name
}

resource "azurerm_network_interface" "main" {
  name                = "example-nic"
  location            = "francecentral"
  resource_group_name = data.azurerm_virtual_network.existing.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_public_ip" "main" {
  name                = "example-publicip"
  location            = "francecentral"
  resource_group_name = data.azurerm_virtual_network.existing.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "devops-20221199"
  location            = "francecentral"
  resource_group_name = data.azurerm_virtual_network.existing.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                = "Standard_D2s_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts"
  version   = "latest"
}

  computer_name  = "hostname"
  admin_username = "devops"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "devops"
    public_key = tls_private_key.ssh.public_key_openssh
  }
}
