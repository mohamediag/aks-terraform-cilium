
# ========================================
# outputs.tf
# ========================================
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the resource group."
}

output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster."
}

# Raw kubeconfig (sensitive). You can save this to a file locally if you wish.
output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "Kubeconfig for the cluster."
}

# Useful connection bits (non-sensitive)
output "kubernetes_host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  description = "API server host."
  sensitive = true
}

output "kubernetes_cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  description = "Cluster CA certificate (base64)."
  sensitive = true
}
