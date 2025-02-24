#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Subnet
#--------------------------------------------*--------------------------------------------

resource "azurecaf_name" "this" {
  name          = lookup(var.settings, "name", null)
  resource_type = "azurerm_subnet"
  suffixes      = lookup(var.settings, "suffixes", [])
  prefixes      = lookup(var.settings, "prefixes", [])
  passthrough   = lookup(var.settings, "passthrough", false)
  clean_input   = lookup(var.settings, "clean_input", true)
  separator     = lookup(var.settings, "separator", "-")
  use_slug      = lookup(var.settings, "use_slug", true)
}

resource "azurerm_subnet" "this" {
  name                                           = azurecaf_name.this.result
  resource_group_name                            = var.resource_group
  virtual_network_name                           = var.vnet_name
  address_prefixes                               = lookup(var.settings, "address_prefixes", null)
  service_endpoints                              = lookup(var.settings, "service_endpoints", null)
  private_endpoint_network_policies              = lookup(var.settings, "private_endpoint_network_policies", "Disabled")
  private_link_service_network_policies_enabled  = lookup(var.settings, "private_link_service_network_policies_enabled", false)

  dynamic "delegation" {
    for_each = lookup(var.settings, "delegation", null) == null ? [] : [1]

    content {
      name = try(var.settings.delegation.name)

      service_delegation {
        name    = try(var.settings.delegation.service_delegation.name)
        actions = lookup(var.settings.delegation, "actions", null)
      }
    }
  }
}

# end
#--------------------------------------------*--------------------------------------------