resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags

  lifecycle {
    ignore_changes = [tags["CreatedDate"]]
  }
}

resource "azurerm_subnet" "nodes" {
  name                 = local.subnet_names.nodes
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes.nodes_subnet
}

# resource "azurerm_subnet" "services" {
#   name                 = local.subnet_names.services
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = var.subnet_address_prefixes.services_subnet
# }

# resource "azurerm_subnet" "private" {
#   name                 = local.subnet_names.private
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = var.subnet_address_prefixes.private_subnet
# }