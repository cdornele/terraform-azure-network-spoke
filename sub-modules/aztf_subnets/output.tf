#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Subnet - Outputs
#--------------------------------------------*--------------------------------------------

output "subnet_id" {
  value = azurerm_subnet.this.id
}

output "subnet_name" {
  value = azurerm_subnet.this.name
}

output "subnet_address_prefixes" {
  value = azurerm_subnet.this.address_prefixes
}


# end
#--------------------------------------------*--------------------------------------------