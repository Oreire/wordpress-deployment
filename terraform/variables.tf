variable "location" {
  description = "Azure region"
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "wordpress-rg"
}

variable "admin_username" {
  description = "Admin username for VM"
  default     = "azureuser"
}

variable "vm_size" {
  description = "Size of the VM"
  default     = "Standard_B2s"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  default     = "id_rsa.pub" 
}



