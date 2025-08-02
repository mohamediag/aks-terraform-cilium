locals {
  # Naming convention: {project}-{environment}-{resource}
  naming_prefix = "${var.project_name}-${var.environment}"
  
  # Resource names
  resource_group_name = var.resource_group_name != "rg-aks-terraform-cilium" ? var.resource_group_name : "rg-${local.naming_prefix}"
  cluster_name        = "${local.naming_prefix}-${var.cluster_name}"
  vnet_name          = "${local.naming_prefix}-vnet"
  
  # Subnet names
  subnet_names = {
    aks      = "${local.naming_prefix}-aks-subnet"
    services = "${local.naming_prefix}-services-subnet" 
    private  = "${local.naming_prefix}-private-subnet"
  }
  
  # NSG names
  nsg_names = {
    aks      = "${local.naming_prefix}-aks-nsg"
    services = "${local.naming_prefix}-services-nsg"
    private  = "${local.naming_prefix}-private-nsg"
  }
  
  # Common tags
  common_tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  })
}