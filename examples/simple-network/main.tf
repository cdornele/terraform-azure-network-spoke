#--------------------------------------------*--------------------------------------------
# Example - Simple Azure Virtual Network Spoke
#--------------------------------------------*--------------------------------------------

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = try(var.settings.location, "eastus")
}

module "network" {
  source = "../../"
  global_settings = try(var.settings.global_settings, {})
  settings = try(var.settings.network, {})
  resource_group = azurerm_resource_group.example.name
  location = try(var.settings.location, "eastus")
  tags = lookup(var.settings, "tags", {})
}

output "subnetXXX" {
  value = module.network.subnets[applicaiton]
}