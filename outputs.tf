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
output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vm_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = azurerm_public_ip.main.ip_address
}

# SSH Connection Info
output "ssh_connection_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i ${var.ssh_key_name}.pem ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
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