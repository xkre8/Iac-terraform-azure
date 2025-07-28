# Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_count
  name  = "${var.vm_name}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username
  computer_name       = var.computer_name
  tags                = var.tags

  # Disable password authentication
  disable_password_authentication = true

   network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = local.ssh_public_key
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = local.selected_image.publisher
    offer     = local.selected_image.offer
    sku       = local.selected_image.sku
    version   = local.selected_image.version
  }

  # Custom data for initial setup
  custom_data = base64encode(templatefile("${path.module}/scripts/setup.sh", {
    admin_username = var.admin_username
  }))

  depends_on = [
    azurerm_network_interface_security_group_association.main
  ]
}