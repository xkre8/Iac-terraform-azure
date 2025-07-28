# ==========================================
# Azure Terraform VM Configuration
# ==========================================

# Resource Group Settings
resource_group_name = "rg-my-terraform-vm"
location           = "Southeast Asia"

# Network Settings
vnet_name                  = "vnet-my-app"
vnet_address_space        = ["10.0.0.0/16"]
subnet_name               = "subnet-my-app"
subnet_address_prefixes   = ["10.0.1.0/24"]

# Virtual Machine Settings
vm_count        = 1
vm_name         = "vm-my-app"
vm_size         = "Standard_B2s"
admin_username  = "azureuser"
computer_name   = "my-app-vm"

# Operating System Settings
# Available options: ubuntu20, ubuntu22, rhel9, rhel8, centos8, debian11, windows2022
os_type = "ubuntu22"

# OS Disk Settings
os_disk_caching              = "ReadWrite"
os_disk_storage_account_type = "Premium_LRS"
os_disk_size_gb              = 30

# Data Disk Settings
data_disk_size_gb              = 10
data_disk_storage_account_type = "Premium_LRS"
data_disk_caching              = "ReadWrite"

# SSH Key Settings
create_new_ssh_key = true
ssh_key_name       = "my-app-key"
# หากต้องการใช้ SSH key ที่มีอยู่แล้ว ให้เปลี่ยนเป็น:
# create_new_ssh_key = false
# existing_ssh_public_key_path = "~/.ssh/id_rsa.pub"

# Network Security Settings
allowed_ssh_source_addresses  = ["0.0.0.0/0"]
allowed_http_source_addresses = ["0.0.0.0/0"]

# Tags
tags = {
  Environment = "Development"
  Project     = "MyApp"
  Owner       = "DevOps"
  CostCenter  = "IT"
}