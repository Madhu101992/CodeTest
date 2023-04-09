#Returns the output of network resource
output "name" {
  value = azurerm_virtual_network.vnet.name
  description = "Name of the Virtual network"
}

output "websubnet_id" {
  value = azurerm_subnet.frontend-subnet.id
  description = "Id of websubnet in the network"
}

output "appsubnet_id" {
  value = azurerm_subnet.backend-subnet.id
  description = "Id of appsubnet in the network"
}

