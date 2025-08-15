# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-terraform-vm"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "Southeast Asia"
}

# Network Variables
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-terraform"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet-terraform"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# VM Variables
variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "vm-terraform"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "computer_name" {
  description = "Computer name for the VM"
  type        = string
  default     = "terraform-vm"
}

# OS Variables
variable "os_disk_caching" {
  description = "Caching type for OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for OS disk"
  type        = string
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 30
}

# Image Variables
variable "os_type" {
  description = "Operating System type - Available options: ubuntu20, ubuntu22, rhel9, rhel8, centos8, debian11, windows2022"
  type        = string
  default     = "ubuntu20"
  
  validation {
    condition = contains([
      "ubuntu20", "ubuntu22", "rhel9", "rhel8", 
      "centos8", "debian11", "windows2022"
    ], var.os_type)
    error_message = "OS type must be one of: ubuntu20, ubuntu22, rhel9, rhel8, centos8, debian11, windows2022"
  }
}

# Legacy image variables (deprecated - use os_type instead)
variable "image_publisher" {
  description = "[DEPRECATED] Use os_type variable instead. Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "[DEPRECATED] Use os_type variable instead. Offer of the VM image"
  type        = string
  default     = "0001-com-ubuntu-server-focal"
}

variable "image_sku" {
  description = "[DEPRECATED] Use os_type variable instead. SKU of the VM image"
  type        = string
  default     = "20_04-lts-gen2"
}

variable "image_version" {
  description = "[DEPRECATED] Use os_type variable instead. Version of the VM image"
  type        = string
  default     = "latest"
}

# SSH Key Variables
variable "create_new_ssh_key" {
  description = "Whether to create a new SSH key pair"
  type        = bool
  default     = true
}

variable "existing_ssh_public_key_path" {
  description = "Path to existing SSH public key file"
  type        = string
  default     = ""
}

variable "existing_ssh_private_key_path" {
  description = "Path to existing SSH private key file"
  type        = string
  default     = ""
}

variable "ssh_key_name" {
  description = "Name for the SSH key pair"
  type        = string
  default     = "terraform-key"
}

# Security Variables
variable "allowed_ssh_source_addresses" {
  description = "List of IP addresses allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"] 
}

variable "allowed_http_source_addresses" {
  description = "List of IP addresses allowed to access HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "Terraform-VM"
    Owner       = "DevOps-Team"
  }
}
# VM Count Variable
variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

# Data Disk Variables
variable "data_disk_configs" {
  description = "Configuration for multiple data disks"
  type = list(object({
    name                 = string
    size_gb             = number
    storage_account_type = string
    caching             = string
  }))
  default = [
    {
      name                 = "data-disk-1"
      size_gb             = 10
      storage_account_type = "Premium_LRS"
      caching             = "ReadWrite"
    }
  ]
}

# Legacy Data Disk Variables (for backward compatibility)
variable "data_disk_size_gb" {
  description = "[DEPRECATED] Use data_disk_configs instead. Size of the data disk in GB"
  type        = number
  default     = 10
}

variable "data_disk_storage_account_type" {
  description = "[DEPRECATED] Use data_disk_configs instead. Storage account type for data disk"
  type        = string
  default     = "Premium_LRS"
}

variable "data_disk_caching" {
  description = "[DEPRECATED] Use data_disk_configs instead. Caching type for data disk"
  type        = string
  default     = "ReadWrite"
}