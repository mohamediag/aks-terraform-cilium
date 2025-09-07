
# ========================================
# variables.tf
# ========================================
variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "demo"
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "eastus"
}

variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for AKS nodes."
  type        = string
  default     = "Standard_B2ms"
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default     = {
    environment = "dev"
    provisioner = "terraform"
  }
}
