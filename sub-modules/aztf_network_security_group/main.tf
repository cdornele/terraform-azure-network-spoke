#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Network Security Groups
#--------------------------------------------*--------------------------------------------

resource "azurecaf_name" "this" {
  for_each      = {
                    for key, value in var.subnets : key => value
                    if try(value.nsg_key, null) != null && try(var.settings[value.nsg_key].version, 0) == 0
                  }
  name          = try(var.settings[each.value.nsg_key].name, null)
  resource_type = "azurerm_network_security_group"
  suffixes      = try(var.settings[each.value.nsg_key].suffixes, [])
  prefixes      = try(var.settings[each.value.nsg_key].prefixes, [])
  clean_input   = try(var.settings[each.value.nsg_key].clean_input, true)
  separator     = try(var.settings[each.value.nsg_key].separator, "-")
  use_slug      = try(var.settings[each.value.nsg_key].use_slug, true)
}

resource "azurerm_network_security_group" "this" {
  for_each            = {
                            for key, value in var.subnets : key => value
                            if try(value.nsg_key, null) != null && try(var.settings[value.nsg_key].version, 0) == 0
                        }
  name                = azurecaf_name.this[each.key].result
  resource_group_name = var.resource_group
  location            = var.location
  tags                = merge(var.tags, try(var.settings[each.value.nsg_key].tags, {}))
  dynamic "security_rule" {
    for_each          = try(var.settings[each.value.nsg_key].rules, [])
    content {
      name                         = try(security_rule.value.name, null)
      priority                     = try(security_rule.value.priority, null)
      direction                    = try(security_rule.value.direction, null)
      access                       = try(security_rule.value.access, null)
      protocol                     = try(security_rule.value.protocol, null)
      source_port_range            = try(security_rule.value.source_port_range, null)
      source_port_ranges           = try(security_rule.value.source_port_ranges, null)
      destination_port_range       = try(security_rule.value.destination_port_range, null)
      destination_port_ranges      = try(security_rule.value.destination_port_ranges, null)
      source_address_prefix        = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes      = try(security_rule.value.source_address_prefixes, null)
      destination_address_prefix   = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes = try(security_rule.value.destination_address_prefixes, null)
      description                  = try(security_rule.value.description, null)
    }
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# end
#--------------------------------------------*--------------------------------------------