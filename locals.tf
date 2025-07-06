locals {
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
  chmod_command = local.is_windows ? "icacls ${var.ssh_key_name}.pem /inheritance:r /grant:r %USERNAME%:R" : "chmod 600 ${var.ssh_key_name}.pem"
}