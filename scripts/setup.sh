#!/bin/bash

# Setup script for VM initialization
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

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add user to docker group
sudo usermod -aG docker ${admin_username}

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Python3 and pip
sudo apt-get install -y python3 python3-pip

# Install useful Python packages
pip3 install --user ansible

# Create a welcome message
sudo tee /etc/motd > /dev/null <<EOF
*****************************************************
*  Welcome to your Terraform-provisioned Azure VM  *
*****************************************************
* VM Name: $(hostname)
* OS: Ubuntu 20.04 LTS
* Provisioned by: Terraform
* Date: $(date)
*****************************************************
EOF

# Enable and start services
sudo systemctl enable docker
sudo systemctl start docker

# Create log entry
echo "VM setup completed at $(date)" | sudo tee -a /var/log/terraform-setup.log