resource "azurerm_public_ip" "runner_public_ip" {
  name                = "runner-public-ip"
  resource_group_name = azurerm_resource_group.loadtest.name
  location            = azurerm_resource_group.loadtest.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "runner_nic" {
  name                = "runner-nic"
  location            = azurerm_resource_group.loadtest.location
  resource_group_name = azurerm_resource_group.loadtest.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.runner_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.runner_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "runner" {
  name                = "loadtest-runner"
  resource_group_name = azurerm_resource_group.loadtest.name
  location            = azurerm_resource_group.loadtest.location

  size                = "Standard_F4" # 4vCPU, 8GB
  admin_username      = "ubuntu"

  network_interface_ids = [
    azurerm_network_interface.runner_nic.id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file(var.ssh_key_file_path)
  }

  os_disk {
    caching              = "ReadWrite"
    # LRS is locally redundant storage, we don't need ZRS
    storage_account_type = "StandardSSD_LRS"
  }

  # get values for this via `az vm image list --all --publisher="Canonical"`
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "22.04.202307250"
  }
}