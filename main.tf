# ========================================
# main.tf
# ========================================

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-rg"
  location = var.location
  tags     = var.tags
}

# AKS Cluster (simple: single default node pool, system-assigned identity)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.name_prefix}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.name_prefix}-dns"

  # Enable RBAC (recommended)
  role_based_access_control_enabled = true

  # Default node pool
  default_node_pool {
    name       = "system"
    vm_size    = var.vm_size
    node_count = var.node_count
    # You can set availability_zones if you like:
    # availability_zones = ["1", "2", "3"]
  }

  # Managed identity (no service principal needed)
  identity {
    type = "SystemAssigned"
  }

  # Simple, production-ready LB and Azure CNI
  network_profile {
    network_plugin    = "azure"    # Azure CNI
    load_balancer_sku = "standard" # required for most scenarios
    # network_policy can be "azure" or "calico" with Azure CNI; leaving unset is fine for simple clusters
    # network_policy    = "azure"
  }

  tags = var.tags
}
