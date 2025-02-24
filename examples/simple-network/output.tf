#--------------------------------------------*--------------------------------------------
# Example - Simple Azure Virtual Network Spoke
#--------------------------------------------*--------------------------------------------

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = module.network.virtual_network_id
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = module.network.virtual_network_name
}

output "virtual_network_address_space" {
  description = "The address space of the virtual network"
  value       = module.network.virtual_network_address_space
}

output "subnets" {
  description = "The subnets in the virtual network"
  value       = module.network.subnets
}

output "network_security_groups" {
  description = "The network security groups in the virtual network"
  value       = module.network.network_security_group
}

output "route_tables" {
  description = "The route tables in the virtual network"
  value       = module.network.route_tables
}
