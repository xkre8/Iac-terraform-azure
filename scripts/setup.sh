#!/bin/bash

# Basic VM Setup Script
# This script will be executed when the VM boots up

# Update package list
sudo apt-get update

# Install essential packages
sudo apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    tree \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Create a welcome message
sudo tee /etc/motd > /dev/null <<EOF
*****************************************************
*  Welcome to your Terraform-provisioned Azure VM  *
*****************************************************
*  VM Name: $(hostname)                             *
*  User: ${admin_username}                          *
*  OS: $(lsb_release -d | cut -f2)                  *
*  Created: $(date)                                 *
*****************************************************
*  Essential tools installed:                       *
*  - curl, wget, git, vim, htop, tree              *
*  - Basic development tools                        *
*****************************************************
EOF

# Set timezone to Bangkok
sudo timedatectl set-timezone Asia/Bangkok

# Create basic directories
mkdir -p /home/${admin_username}/{projects,scripts,logs}
chown ${admin_username}:${admin_username} /home/${admin_username}/{projects,scripts,logs}

# Enable and start SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

echo "Basic VM setup completed successfully!"
echo "VM setup completed at $(date)" | sudo tee -a /var/log/terraform-setup.log