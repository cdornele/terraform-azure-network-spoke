#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Network Spoke - Outputs
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

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in module.subnets : k => v.subnet_id }
}

output "subnet_objects" {
  description = "Map of subnet objects"
  value       = { for k, v in module.subnets : k => v.subnet_object }
}

output "network_security_group_ids" {
  description = "Map of network security group IDs"
  value       = module.nsg.network_security_group_ids
}

output "network_security_group_objects" {
  description = "Map of network security group objects"
  value       = module.nsg.network_security_group_objects
}

output "route_table_ids" {
  description = "Map of route table IDs"
  value       = module.rts.ids
}

output "route_table_objects" {
  description = "Map of route table objects"
  value       = module.rts.rts_obj
}

# Deprecated outputs - kept for backward compatibility
output "subnets" {
  description = "The subnets in the virtual network (deprecated - use subnet_ids and subnet_objects instead)"
  value       = module.subnets.*
  deprecated  = "This output is deprecated and will be removed in a future version. Use subnet_ids and subnet_objects instead."
}

output "network_security_group" {
  description = "The network security groups in the virtual network (deprecated - use network_security_group_ids and network_security_group_objects instead)"
  value       = module.nsg.*
  deprecated  = "This output is deprecated and will be removed in a future version. Use network_security_group_ids and network_security_group_objects instead."
}

output "route_tables" {
  description = "The route tables in the virtual network (deprecated - use route_table_ids and route_table_objects instead)"
  value       = module.rts.*
  deprecated  = "This output is deprecated and will be removed in a future version. Use route_table_ids and route_table_objects instead."
}

# end
#--------------------------------------------*--------------------------------------------