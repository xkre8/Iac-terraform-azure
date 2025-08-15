# Multiple Data Disks
resource "azurerm_managed_disk" "data" {
  count                = var.vm_count * length(var.data_disk_configs)
  name                 = "${var.vm_name}-${var.data_disk_configs[count.index % length(var.data_disk_configs)].name}-${floor(count.index / length(var.data_disk_configs)) + 1}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = var.data_disk_configs[count.index % length(var.data_disk_configs)].storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disk_configs[count.index % length(var.data_disk_configs)].size_gb
  tags                 = var.tags
}

# Attach Multiple Data Disks to VM
resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  count              = var.vm_count * length(var.data_disk_configs)
  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.main[floor(count.index / length(var.data_disk_configs))].id
  lun                = count.index % length(var.data_disk_configs)
  caching            = var.data_disk_configs[count.index % length(var.data_disk_configs)].caching
}