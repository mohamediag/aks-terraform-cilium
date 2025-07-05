resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-terraform-cluster"
  location            = azurerm_resource_group.R1-project-e2e.location
  resource_group_name = azurerm_resource_group.R1-project-e2e.name
  dns_prefix          = "aks-terraform"

  default_node_pool {
    name                = "default"
    node_count          = 2
    vm_size             = "Standard_B2ms"
    vnet_subnet_id      = azurerm_subnet.subnet1.id  # Use one of your subnets here
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr = "10.0.4.0/24"
    dns_service_ip = "10.0.4.5"
  }

}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}