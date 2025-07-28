locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
  chmod_command = local.is_windows ? "icacls ${var.ssh_key_name}.pem /inheritance:r /grant:r %USERNAME%:R" : "chmod 600 ${var.ssh_key_name}.pem"
  
  # OS Images configuration
  os_images = {
    "ubuntu20" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
      description = "Ubuntu 20.04 LTS"
    }
    "ubuntu22" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
      description = "Ubuntu 22.04 LTS"
    }
    "rhel9" = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "9-lvm-gen2"
      version   = "latest"
      description = "Red Hat Enterprise Linux 9"
    }
    "rhel8" = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8-lvm-gen2"
      version   = "latest"
      description = "Red Hat Enterprise Linux 8"
    }
    "centos8" = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_5-gen2"
      version   = "latest"
      description = "CentOS 8.5"
    }
    "debian11" = {
      publisher = "Debian"
      offer     = "debian-11"
      sku       = "11-gen2"
      version   = "latest"
      description = "Debian 11"
    }
    "windows2022" = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-datacenter-azure-edition"
      version   = "latest"
      description = "Windows Server 2022"
    }
  }
  
  # Selected OS image based on variable
  selected_image = local.os_images[var.os_type]
}