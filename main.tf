#--------------------------------------------*--------------------------------------------
# Module: Azure Vritual Network Spoke
#--------------------------------------------*--------------------------------------------

resource "azurecaf_name" "this" {
  name          = lookup(var.global_settings, "name", null)
  resource_type = "azurerm_virtual_network"
  prefixes      = lookup(var.global_settings, "prefixes", [])
  suffixes      = lookup(var.global_settings, "suffixes", [])
  passthrough   = lookup(var.global_settings, "passthrough", false)
  clean_input   = lookup(var.global_settings, "clean_input", true)
  separator     = lookup(var.global_settings, "separator", "-")
  random_length = lookup(var.global_settings, "random_length", 0)
  random_seed   = lookup(var.global_settings, "random_seed", 1) 
  use_slug      = lookup(var.global_settings, "use_slug", true)
}

# Virtual Network

resource "azurerm_virtual_network" "this" {
  depends_on          = [
                        azurecaf_name.this
                        ]
  name                = azurecaf_name.this.result
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = try(var.settings.address_space, [])
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Custom DNS servers

resource "azurerm_virtual_network_dns_servers" "this" {
  count              = try(var.settings.dns_servers_enabled, false) == true ? 1 : 0
  virtual_network_id = azurerm_virtual_network.this.id
  dns_servers        = try(var.settings.dns_servers_list, [])
  depends_on = [
    azurerm_virtual_network.this
  ]
}

# Subnets

module "subnets" {
    depends_on              = [
                                azurerm_virtual_network.this
                              ]
    for_each                = lookup(var.settings.subnet_settings, "subnets", {})
    source                  = "./sub-modules/aztf_subnets"
    settings                = each.value
    resource_group          = var.resource_group
    vnet_name               = azurerm_virtual_network.this.name
}

# Network Security Groups

module "nsg" {
  depends_on                        = [
                                        module.subnets
                                      ]
  source                            = "./sub-modules/aztf_network_security_group"
  resource_group                    = var.resource_group
  location                          = var.location
  subnets                           = lookup(var.settings.subnet_settings, "subnets", {}) 
  settings                          = lookup(var.settings, "network_security_group_settings", {})
  tags                              = merge(lookup(var.settings, "tags", {}), lookup(var.settings.network_security_group_settings, "tags", {}))
}

resource "azurerm_subnet_network_security_group_association" "this" {
  depends_on                        = [
                                      module.nsg,
                                      module.subnets
                                      ]
  for_each                          = {
                                        for key, value in try(var.settings.subnet_settings.subnets, {}) : key => value
                                        if try(var.settings.network_security_group_settings[value.nsg_key].version, 0) == 0 && try(value.nsg_key, null) != null
                                      }

  subnet_id                         = module.subnets[each.key].subnet_id
  network_security_group_id         = module.nsg.network_security_group_objects[each.key].id
}

# Route Tables

module "rts" {
  depends_on             = [
                            module.subnets
                         ]
  source                 = "./sub-modules/aztf_route_table"
  location               = var.location
  resource_group         = var.resource_group
  subnets                = lookup(var.settings.subnet_settings, "subnets", {})
  settings               = lookup(var.settings, "route_tables_settings", {})
  tags                   = merge(lookup(var.settings, "tags", {}), lookup(var.settings.route_tables_settings, "tags", {}))
}

resource "azurerm_subnet_route_table_association" "subnet_rts_association" {
  depends_on            = [
                            module.rts,
                            module.subnets
                          ]
  for_each              = {
                            for key, value in try(var.settings.subnet_settings.subnets, {}) : key => value
                            if lookup(var.settings.route_tables_settings[value.rts_key], "is_Enabled", false) == true && try(value.rts_key, null) != null
                          }
  subnet_id             = module.subnets[each.key].subnet_id
  route_table_id        = module.rts.rts_obj[each.key].id
}