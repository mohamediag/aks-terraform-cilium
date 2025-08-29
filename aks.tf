resource "azurerm_kubernetes_cluster" "main" {
  name                = local.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = local.naming_prefix
  kubernetes_version  = var.kubernetes_version
  tags                = local.common_tags

  private_cluster_enabled = var.enable_private_cluster
  
  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }
  #role_based_access_control_enabled   = false
  azure_policy_enabled               = true
  #http_application_routing_enabled   = false
  #oidc_issuer_enabled               = false
  #workload_identity_enabled         = false

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = azurerm_subnet.nodes.id
    #type                = "VirtualMachineScaleSets"
    #enable_auto_scaling = true
    #min_count           = 2
    #max_count           = 5
    #os_disk_size_gb    = 30
    #zones              = ["1", "2", "3"]
    

  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_policy      = "azure"
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
    load_balancer_sku   = "standard"
    outbound_type       = "loadBalancer"
  }


  # key_vault_secrets_provider {
  #   secret_rotation_enabled = true
  # }

  //microsoft_defender {
    //log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  //}

  //oms_agent {
    //log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  //}

  lifecycle {
    ignore_changes = [
      kubernetes_version,
      default_node_pool[0].node_count,
      tags["CreatedDate"],
      identity[0].identity_ids,
      api_server_access_profile
    ]
  }
}


# Log Analytics Workspace for monitoring
/* resource "azurerm_log_analytics_workspace" "main" {
  name                = "${local.naming_prefix}-law"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
} */
