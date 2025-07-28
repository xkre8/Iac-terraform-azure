# Data Disk
resource "azurerm_managed_disk" "data" {
  count                = var.vm_count
  name                 = "${var.vm_name}-data-disk-${count.index + 1}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.data_disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_size_gb
  tags                 = var.tags
}

# Attach Data Disk to VM
resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  count              = var.vm_count
  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.main[count.index].id
  lun                = 0
  caching            = var.data_disk_caching
}