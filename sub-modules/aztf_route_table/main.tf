#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Route Table
#--------------------------------------------*--------------------------------------------

resource "azurecaf_name" "this" {
  for_each           = {
                            for key, value in var.subnets : key => value
                            if try(value.rts_key, null) != null && try(var.settings[value.rts_key].version, 0) == 0
                        }
  name          = lookup(var.settings[each.value.rts_key], "name", null)
  resource_type = "azurerm_route_table"
  suffixes      = lookup(var.settings[each.value.rts_key], "suffixes", [])
  prefixes      = lookup(var.settings[each.value.rts_key], "prefixes", [])
  clean_input   = lookup(var.settings[each.value.rts_key], "clean_input", true)
  separator     = lookup(var.settings[each.value.rts_key], "separator", "-")
  use_slug      = lookup(var.settings[each.value.rts_key], "use_slug", true)
}

resource "azurerm_route_table" "this" {
  for_each                      = {
                                    for key, value in var.subnets : key => value
                                    if try(value.rts_key, null) != null && try(var.settings[value.rts_key].version, 0) == 0
                                }
  name                          = azurecaf_name.this[each.key].result
  location                      = var.location
  resource_group_name           = var.resource_group  
  bgp_route_propagation_enabled = lookup(var.settings[each.value.rts_key], "bgp_route_propagation_enable", false)
  dynamic "route" {
    for_each = try(var.settings[each.value.rts_key].rts, [])
    content {
      name                      = lookup(route.value, "name", null)
      address_prefix            = lookup(route.value, "address_prefix", null)
      next_hop_type             = lookup(route.value, "next_hop_type", null)
      next_hop_in_ip_address    = try(lower(lookup(route.value, "next_hop_type", null)), null) == "virtualappliance" ? coalesce(lookup(route.value, "next_hop_in_ip_address", null)) : null
    }
  }
  tags                          = merge(var.tags, lookup(var.settings[each.value.rts_key], "tags", {}))
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# end
#--------------------------------------------*--------------------------------------------