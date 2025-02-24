#--------------------------------------------*--------------------------------------------
# Module: Azure Vritual Network Spoke - Outputs
#--------------------------------------------*--------------------------------------------

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.this.address_space
}

output "subnets" {
  description = "The subnets in the virtual network"
  value       = module.subnets.*
}

output "network_security_group" {
  description = "The network security groups in the virtual network"
  value       = module.nsg.*
}

output "route_tables" {
  description = "The route tables in the virtual network"
  value       = module.rts.*
}

# end
#--------------------------------------------*--------------------------------------------