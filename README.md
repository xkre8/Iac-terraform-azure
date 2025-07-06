# Iac-terraform-azure

# Terraform Azure VM Infrastructure

โครงการสำหรับสร้าง Virtual Machine บน Azure Cloud โดยใช้ Terraform

## 📋 โครงสร้างโปรเจค

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

## 🚀 วิธีใช้งาน

### 1. เตรียมความพร้อม
```bash
# ติดตั้ง Azure CLI
az login

# ติดตั้ง Terraform
terraform version
```

### 2. ตั้งค่า Variables
```bash
# คัดลอกไฟล์ template
cp terraform.tfvars.example terraform.tfvars

# แก้ไขค่าต่างๆ ใน terraform.tfvars
```

### 3. รัน Terraform
```bash
# เริ่มต้น Terraform
terraform init

# ตรวจสอบแผนการ
terraform plan

# สร้าง Infrastructure
terraform apply

# ลบ Infrastructure
terraform destroy
```

## 🔧 การตั้งค่า

### Variables ที่ต้องกำหนด
สร้างไฟล์ `terraform.tfvars` และกำหนดค่าต่อไปนี้:

```hcl
# Azure Configuration
subscription_id = "your-subscription-id"
resource_group_name = "your-resource-group"
location = "Southeast Asia"

# VM Configuration
vm_name = "your-vm-name"
vm_size = "Standard_B2s"
admin_username = "azureuser"

# Network Configuration
vnet_name = "your-vnet"
subnet_name = "your-subnet"
```

### SSH Keys
```bash
# สร้าง SSH Key pair
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure_vm_key

# Public key จะถูกใช้ใน keys.tf
```

## 📁 ไฟล์ .gitignore

สร้างไฟล์ `.gitignore` ในโฟลเดอร์หลักเพื่อป้องกันไฟล์สำคัญ:

```gitignore
# Terraform State Files
*.tfstate
*.tfstate.*
*.tfstate.backup
.terraform/
.terraform.lock.hcl
terraform.tfplan
terraform.tfplan.*

# Variable Files (Contains Sensitive Data)
terraform.tfvars
*.tfvars
!terraform.tfvars.example

# SSH Keys
*.pem
*.key
id_rsa*
*.pub

# Azure Files
.azure/
*.azureauth

# OS Generated Files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE Files
.vscode/
.idea/
*.swp
*.swo
*~

# Log Files
*.log
logs/

# Backup Files
*.bak
*.backup
*.orig

# Environment Files
.env
.env.local
.env.*.local
```

## 🛡️ ความปลอดภัย

### ข้อควรระวัง
- ❌ **ห้าม commit** ไฟล์ `terraform.tfvars` ที่มีข้อมูลสำคัญ
- ❌ **ห้าม commit** SSH private keys
- ❌ **ห้าม commit** Azure credentials
- ✅ **ควรใช้** Azure Key Vault สำหรับ secrets
- ✅ **ควรใช้** Environment variables หรือ Azure Service Principal

### Best Practices
```bash
# ใช้ Environment Variables
export ARM_CLIENT_ID="your-client-id"
export ARM_CLIENT_SECRET="your-client-secret"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"
```

## 📝 ตัวอย่างไฟล์ terraform.tfvars.example

```hcl
# Azure Configuration
subscription_id = "00000000-0000-0000-0000-000000000000"
resource_group_name = "rg-terraform-demo"
location = "Southeast Asia"

# VM Configuration
vm_name = "vm-terraform-demo"
vm_size = "Standard_B2s"
admin_username = "azureuser"

# Network Configuration
vnet_address_space = ["10.0.0.0/16"]
subnet_address_prefixes = ["10.0.1.0/24"]

# Tags
environment = "development"
project = "terraform-demo"
```

## 🔍 การแก้ไขปัญหา

### ปัญหาที่เจอบ่อย
1. **Authentication Error**: ตรวจสอบ Azure CLI login
2. **Permission Denied**: ตรวจสอบสิทธิ์ใน Azure Subscription
3. **Resource Already Exists**: ตรวจสอบชื่อ resource ที่ซ้ำกัน

### Commands ที่มีประโยชน์
```bash
# ตรวจสอบ Terraform state
terraform state list

# ดู resource details
terraform state show <resource-name>

# Import existing resource
terraform import <resource-type>.<name> <azure-resource-id>

# Format code
terraform fmt

# Validate configuration
terraform validate
```

## 📞 การติดต่อ

หากมีปัญหาหรือคำถาม สามารถ:
- สร้าง Issue ใน repository นี้
- ดูเอกสาร [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- ดูเอกสาร [Azure Documentation](https://docs.microsoft.com/en-us/azure/)

---

## 📌 หมายเหตุ

⚠️ **ข้อควรระวัง**: การใช้ Terraform จะสร้าง Azure resources ที่อาจมีค่าใช้จ่าย กรุณาตรวจสอบราคาก่อนใช้งาน และอย่าลืม `terraform destroy` เมื่อทดสอบเสร็จแล้ว