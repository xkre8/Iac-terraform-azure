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
variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "0001-com-ubuntu-server-focal"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "20_04-lts-gen2"
}

variable "image_version" {
  description = "Version of the VM image"
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