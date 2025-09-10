#!/bin/bash

# Enhanced VM Setup Script with Docker & Kubernetes
# This script will be executed when the VM boots up

set -e  # Exit on error

echo "Starting VM setup with Docker & Kubernetes..."

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
    lsb-release \
    jq \
    net-tools

echo "Essential packages installed..."

# ==========================================
# Install Docker
# ==========================================
echo "Installing Docker..."

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list and install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker ${admin_username}

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation completed!"

# ==========================================
# Install Kubernetes tools
# ==========================================
echo "Installing Kubernetes tools..."

# Add Kubernetes GPG key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package list and install Kubernetes tools
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# Hold Kubernetes packages to prevent automatic updates
sudo apt-mark hold kubelet kubeadm kubectl

echo "Kubernetes tools installation completed!"

# ==========================================
# Install additional useful tools
# ==========================================
echo "Installing additional tools..."

# Install helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install -y helm

# Install k9s (Kubernetes CLI management tool)
wget -qO- https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz | tar xvz
sudo mv k9s /usr/local/bin/
sudo chmod +x /usr/local/bin/k9s

echo "Additional tools installation completed!"

# ==========================================
# Configuration
# ==========================================
echo "Setting up configurations..."

# Configure containerd for Kubernetes
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd

# Enable kubelet
sudo systemctl enable kubelet

# Set timezone to Bangkok
sudo timedatectl set-timezone Asia/Bangkok

# Create directories
mkdir -p /home/${admin_username}/{projects,scripts,logs,k8s-manifests}
chown -R ${admin_username}:${admin_username} /home/${admin_username}/{projects,scripts,logs,k8s-manifests}

# Create useful aliases for the user
sudo tee /home/${admin_username}/.bash_aliases > /dev/null <<EOF
# Docker aliases
alias dk='docker'
alias dkc='docker-compose'
alias dkps='docker ps'
alias dkimg='docker images'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgn='kubectl get nodes'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'

# General aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
EOF

chown ${admin_username}:${admin_username} /home/${admin_username}/.bash_aliases

# Create a comprehensive welcome message
sudo tee /etc/motd > /dev/null <<EOF
*****************************************************
*  Welcome to your Terraform-provisioned Azure VM  *
*****************************************************
*  VM Name: $(hostname)                             *
*  User: ${admin_username}                          *
*  OS: $(lsb_release -d | cut -f2)                  *
*  Created: $(date)                                 *
*****************************************************
*  🐳 Docker version: $(docker --version 2>/dev/null || echo "Installing...")
*  ☸️  Kubernetes tools:                            *
*     - kubectl: $(kubectl version --client --short 2>/dev/null || echo "Installing...")
*     - kubeadm: $(kubeadm version -o short 2>/dev/null || echo "Installing...")
*     - kubelet: $(systemctl is-active kubelet 2>/dev/null || echo "Ready to start")
*  ⚓ Helm: $(helm version --short 2>/dev/null || echo "Installing...")
*****************************************************
*  Useful commands:                                 *
*  - docker ps                  # List containers   *
*  - kubectl get nodes          # List K8s nodes    *
*  - k9s                        # K8s management UI *
*  - helm list                  # List helm charts  *
*****************************************************
*  Note: You may need to log out and back in       *
*  for Docker group permissions to take effect.    *
*****************************************************
EOF

# Enable and start SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

# Create setup completion marker
echo "VM setup completed successfully at $(date)" | sudo tee /var/log/terraform-setup.log

echo "✅ VM setup completed successfully!"
echo "🐳 Docker installed and configured"
echo "☸️  Kubernetes tools (kubectl, kubeadm, kubelet) installed"
echo "⚓ Helm installed"
echo "🎯 K9s installed for Kubernetes management"
echo ""
echo "Next steps:"
echo "1. Log out and back in for Docker permissions"
echo "2. Initialize Kubernetes cluster: sudo kubeadm init"
echo "3. Configure kubectl: mkdir -p ~/.kube && sudo cp /etc/kubernetes/admin.conf ~/.kube/config"