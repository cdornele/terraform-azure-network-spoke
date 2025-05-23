#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Subnet
#--------------------------------------------*--------------------------------------------

resource "azurecaf_name" "this" {
  name          = try(var.settings.name, null)
  resource_type = "azurerm_subnet"
  suffixes      = try(var.settings.suffixes, [])
  prefixes      = try(var.settings.prefixes, [])
  passthrough   = try(var.settings.passthrough, false)
  clean_input   = try(var.settings.clean_input, true)
  separator     = try(var.settings.separator, "-")
  use_slug      = try(var.settings.use_slug, true)
}

resource "azurerm_subnet" "this" {
  name                                           = azurecaf_name.this.result
  resource_group_name                            = var.resource_group
  virtual_network_name                           = var.vnet_name
  address_prefixes                               = try(var.settings.address_prefixes, null)
  service_endpoints                              = try(var.settings.service_endpoints, null)
  private_endpoint_network_policies              = try(var.settings.private_endpoint_network_policies, "Disabled")
  private_link_service_network_policies_enabled  = try(var.settings.private_link_service_network_policies_enabled, false)

  dynamic "delegation" {
    for_each = try(var.settings.delegation, null) == null ? [] : [1]

    content {
      name = try(var.settings.delegation.name, null)

      service_delegation {
        name    = try(var.settings.delegation.service_delegation.name, null)
        actions = try(var.settings.delegation.actions, null)
      }
    }
  }
  lifecycle {
    ignore_changes = [
      delegation[0].service_delegation[0].actions
    ]
  }
}

# end
#--------------------------------------------*--------------------------------------------