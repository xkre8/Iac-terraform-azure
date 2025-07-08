## 📋 Azure VM with Terraform

```
terraform-azure-vm/
├── main.tf              # Terraform main configuration
├── providers.tf         # Provider configuration (Azure)
├── variables.tf         # Input variables
├── locals.tf           # Local values
├── outputs.tf          # Output values
├── compute.tf          # VM และ compute resources
├── network.tf          # Network configuration
├── security.tf         # Security groups และ rules
├── keys.tf             # SSH keys และ authentication
├── terraform.tfvars    # Variable values (ไม่ควร commit)
├── README.md           # เอกสารนี้
└── scripts/
    ├── install_tools.sh # Script สำหรับติดตั้ง tools
    └── setup.sh        # Setup script
```


[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A production-ready Terraform configuration for deploying Linux virtual machines on Microsoft Azure with automated setup, security best practices, and flexible SSH key management.

## 🚀 Features

- **Complete Infrastructure Setup**: Virtual network, subnet, security groups, and VM in one deployment
- **Flexible SSH Key Management**: Generate new keys or use existing ones
- **Automated VM Configuration**: Pre-installed Docker, Node.js, Python, and essential tools
- **Security Best Practices**: Network security groups with customizable IP restrictions
- **Cross-Platform Support**: Works on Windows, macOS, and Linux
- **Cost Optimized**: Sensible defaults with configurable options
- **Modular Design**: Easy to extend and customize

## 📋 Prerequisites

Before you begin, ensure you have the following installed and configured:

### Required Tools
- **[Terraform](https://www.terraform.io/downloads.html)** (version >= 1.0)
- **[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)** (version >= 2.0)
- **Git** (for cloning the repository)

### Azure Account Setup
1. **Active Azure Subscription**
2. **Azure CLI Authentication**:
   ```bash
   az login
   az account set --subscription "your-subscription-id"
   ```

### Verify Installation
```bash
# Check Terraform version
terraform version

# Check Azure CLI version and authentication
az --version
az account show
```

## 🏗️ Project Structure

```
terraform-azure-vm/
├── main.tf              # Core resource definitions
├── providers.tf         # Provider configuration
├── variables.tf         # Input variables
├── locals.tf           # Local computations
├── outputs.tf          # Output values
├── compute.tf          # VM and compute resources
├── network.tf          # Network infrastructure
├── security.tf         # Security groups and rules
├── keys.tf             # SSH key management
├── terraform.tfvars    # Variable values (customize this!)
├── README.md           # This file
└── scripts/
    ├── setup.sh        # VM initialization script
    └── install_tools.sh # Additional tools (optional)
```

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/terraform-azure-vm.git
cd terraform-azure-vm
```

### 2. Customize Configuration
Edit `terraform.tfvars` to match your requirements:

```hcl
# Resource Group Settings
resource_group_name = "rg-my-project"
location           = "Southeast Asia"

# VM Settings
vm_name         = "vm-my-project"
vm_size         = "Standard_B2s"
admin_username  = "azureuser"

# SSH Key Settings
create_new_ssh_key = true
ssh_key_name       = "my-project-key"

# IMPORTANT: Security Settings
# Replace with your actual IP address for better security
allowed_ssh_source_addresses  = ["YOUR_IP_ADDRESS/32"]
allowed_http_source_addresses = ["0.0.0.0/0"]

# Tags
tags = {
  Environment = "Development"
  Project     = "MyProject"
  Owner       = "YourName"
}
```

### 3. Initialize and Deploy
```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply
```

### 4. Connect to Your VM
After deployment, use the SSH command from the output:
```bash
# Example output command
ssh -i my-project-key.pem azureuser@<public-ip-address>
```

## 📊 Cost Estimation

### Monthly Cost Breakdown (Southeast Asia Region)
| Component | Configuration | Estimated Cost |
|-----------|---------------|----------------|
| VM (Standard_B2s) | 2 vCPUs, 4GB RAM | $30-40 |
| OS Disk (Premium SSD) | 30GB | $6 |
| Public IP (Static) | Standard SKU | $3 |
| Network Traffic | Variable | $5-15 |
| **Total** | | **$44-64/month** |

### Cost Optimization Tips
- Use `Standard_B1s` for development ($10-15/month)
- Use Standard HDD storage for non-production ($2/month)
- Consider Azure Hybrid Benefit if you have Windows licenses
- Use spot instances for development workloads (up to 90% savings)

## 🔧 Configuration Options

### VM Sizes
Common options for different use cases:

| Size | vCPUs | RAM | Use Case | Cost/Month |
|------|-------|-----|----------|------------|
| Standard_B1s | 1 | 1GB | Development | $10-15 |
| Standard_B2s | 2 | 4GB | Small apps | $30-40 |
| Standard_D2s_v3 | 2 | 8GB | Production | $70-90 |
| Standard_D4s_v3 | 4 | 16GB | High performance | $140-180 |

### Available Regions
Popular regions with good pricing:
- `Southeast Asia` (Singapore)
- `East Asia` (Hong Kong)
- `Australia East` (Sydney)
- `Japan East` (Tokyo)

## 🔒 Security Best Practices

### Network Security
Our configuration implements several security measures:

1. **Network Security Groups**: Restrict access to specific ports
2. **SSH Key Authentication**: No password authentication
3. **Configurable IP Restrictions**: Control who can access your VM
4. **HTTPS Ready**: Pre-configured for web applications

### Recommended Security Actions After Deployment

1. **Restrict SSH Access**:
   ```bash
   # Get your public IP
   curl ifconfig.me
   
   # Update terraform.tfvars
   allowed_ssh_source_addresses = ["YOUR_IP/32"]
   terraform apply
   ```

2. **Change Default SSH Port** (Optional):
   ```bash
   sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
   sudo systemctl restart sshd
   ```

3. **Enable Automatic Updates**:
   ```bash
   sudo apt update
   sudo apt install unattended-upgrades
   sudo dpkg-reconfigure -plow unattended-upgrades
   ```

## 🛠️ Advanced Usage

### Using Existing SSH Keys
If you already have SSH keys:

```hcl
# In terraform.tfvars
create_new_ssh_key = false
existing_ssh_public_key_path = "~/.ssh/id_rsa.pub"
```

### Multiple Environments
Use Terraform workspaces for different environments:

```bash
# Create environments
terraform workspace new development
terraform workspace new staging
terraform workspace new production

# Switch between environments
terraform workspace select development
```

### Custom VM Setup
Modify `scripts/setup.sh` to install additional software:

```bash
# Add your custom installations
sudo apt-get install -y mysql-server
sudo systemctl enable mysql
```

## 📤 Outputs

After successful deployment, you'll get:

| Output | Description |
|--------|-------------|
| `vm_public_ip` | Public IP address of the VM |
| `vm_private_ip` | Private IP address of the VM |
| `ssh_connection_command` | Ready-to-use SSH command |
| `resource_group_name` | Name of the created resource group |
| `network_security_group_name` | Name of the security group |

## 🔍 Troubleshooting

### Common Issues and Solutions

#### SSH Connection Failed
```bash
# Check if VM is running
az vm show --resource-group <rg-name> --name <vm-name> --show-details

# Verify your IP is allowed
az network nsg rule list --resource-group <rg-name> --nsg-name <nsg-name>

# Check SSH key permissions
chmod 600 your-key.pem
```

#### Terraform Permission Errors
```bash
# Re-authenticate with Azure
az login

# Check current subscription
az account show

# Set correct subscription
az account set --subscription "your-subscription-id"
```

#### VM Not Accessible After Changes
```bash
# Check VM status
az vm get-instance-view --resource-group <rg-name> --name <vm-name>

# Restart VM if needed
az vm restart --resource-group <rg-name> --name <vm-name>
```

## 🧹 Cleanup

To avoid ongoing charges, destroy resources when no longer needed:

```bash
# Destroy all resources
terraform destroy

# Verify cleanup in Azure portal
az group list --tag Project=YourProject
```

## 📝 Variables Reference

### Required Variables
- `resource_group_name`: Name for the resource group
- `location`: Azure region for deployment
- `vm_name`: Name for the virtual machine

### Optional Variables
- `vm_size`: VM size (default: `Standard_B2s`)
- `admin_username`: SSH username (default: `azureuser`)
- `allowed_ssh_source_addresses`: IP ranges allowed for SSH
- `create_new_ssh_key`: Generate new SSH keys (default: `true`)
- `tags`: Resource tags for organization

See `variables.tf` for complete list and descriptions.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/terraform-azure-vm/issues) page
2. Create a new issue with detailed information
3. Include your Terraform version and error messages

## 🙏 Acknowledgments

- [HashiCorp Terraform](https://www.terraform.io/) for the amazing infrastructure tool
- [Microsoft Azure](https://azure.microsoft.com/) for the cloud platform
- The open-source community for inspiration and best practices

## 🔗 Related Projects

- [Terraform Azure Examples](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)
- [Azure Quick Start Templates](https://github.com/Azure/azure-quickstart-templates)

---

**Made with ❤️ by [Your Name]**

*If this project helped you, please consider giving it a ⭐ on GitHub!*