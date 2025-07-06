# Generate SSH Key Pair (if create_new_ssh_key is true)
resource "tls_private_key" "main" {
  count     = var.create_new_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save Private Key to Local File
resource "local_file" "private_key" {
  count    = var.create_new_ssh_key ? 1 : 0
  content  = tls_private_key.main[0].private_key_pem
  filename = "${var.ssh_key_name}.pem"
  
  provisioner "local-exec" {
    command = local.chmod_command
  }
}

# Save Public Key to Local File
resource "local_file" "public_key" {
  count    = var.create_new_ssh_key ? 1 : 0
  content  = tls_private_key.main[0].public_key_openssh
  filename = "${var.ssh_key_name}.pub"
}

# Read Existing SSH Public Key (if using existing key)
data "local_file" "existing_ssh_public_key" {
  count    = var.create_new_ssh_key ? 0 : 1
  filename = var.existing_ssh_public_key_path
}

# Local variable to determine which SSH key to use
locals {
  ssh_public_key = var.create_new_ssh_key ? tls_private_key.main[0].public_key_openssh : data.local_file.existing_ssh_public_key[0].content
}