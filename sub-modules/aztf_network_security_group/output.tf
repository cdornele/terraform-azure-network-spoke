#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Network Security Groups - Outputs
#--------------------------------------------*--------------------------------------------

output "network_security_group_ids" {
  description = "The IDs of the network security groups"
  value       = azurerm_network_security_group.this.*
}

output "network_security_group_objects" {
  description = "The network security groups"
  value       = azurerm_network_security_group.this
}

# end
#--------------------------------------------*--------------------------------------------