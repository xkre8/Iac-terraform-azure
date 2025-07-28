# Resource Group
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.main.location
}

# Network
output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.main.name
}

# VM Information
output "vm_names" {
  description = "Names of the virtual machines"
  value       = azurerm_linux_virtual_machine.main[*].name
}

output "vm_ids" {
  description = "IDs of the virtual machines"
  value       = azurerm_linux_virtual_machine.main[*].id
}

output "vm_private_ips" {
  description = "Private IP addresses of the virtual machines"
  value       = azurerm_network_interface.main[*].private_ip_address
}

output "vm_public_ips" {
  description = "Public IP addresses of the virtual machines"
  value       = azurerm_public_ip.main[*].ip_address
}

output "ssh_connection_commands" {
  description = "SSH commands to connect to the VMs"
  value       = [for i in range(var.vm_count) : "ssh -i ${var.ssh_key_name}.pem ${var.admin_username}@${azurerm_public_ip.main[i].ip_address}"]
}

output "ssh_private_key_path" {
  description = "Path to the SSH private key file"
  value       = var.create_new_ssh_key ? "${var.ssh_key_name}.pem" : "Use your existing private key"
}

# Security Group
output "network_security_group_name" {
  description = "Name of the network security group"
  value       = azurerm_network_security_group.main.name
}

# Data Disk Information
output "data_disk_names" {
  description = "Names of the data disks"
  value       = azurerm_managed_disk.data[*].name
}

output "data_disk_ids" {
  description = "IDs of the data disks"
  value       = azurerm_managed_disk.data[*].id
}

# OS Information
output "selected_os_info" {
  description = "Information about the selected operating system"
  value = {
    os_type     = var.os_type
    description = local.selected_image.description
    publisher   = local.selected_image.publisher
    offer       = local.selected_image.offer
    sku         = local.selected_image.sku
  }
}

output "available_os_types" {
  description = "List of available OS types"
  value = {
    for key, value in local.os_images : key => value.description
  }
}