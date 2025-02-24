#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Route Table - Outputs
#--------------------------------------------*--------------------------------------------

output "ids" {
  description = "The IDs of the Route Tables."
  value = azurerm_route_table.this.*
}

output "rts_obj" {
  description = "Object of the Route Tables."
  value = azurerm_route_table.this
}

# end
#--------------------------------------------*--------------------------------------------