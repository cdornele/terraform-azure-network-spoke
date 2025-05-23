#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Network Spoke - Validations
#--------------------------------------------*--------------------------------------------

locals {
  # Validate required settings
  validate_settings = {
    address_space_exists = (
      try(length(var.settings.address_space) > 0, false) 
      ? true 
      : tobool("Error: address_space is required in var.settings")
    )
  }

  # Validate subnet address prefixes if subnets are provided
  validate_subnet_settings = {
    valid_subnets = (
      try(length(var.settings.subnet_settings.subnets) > 0, false) 
      ? { 
          for key, subnet in var.settings.subnet_settings.subnets : 
          key => (
            try(length(subnet.address_prefixes) > 0, false) 
            ? true 
            : tobool("Error: address_prefixes is required for subnet ${key}")
          )
        } 
      : {}
    )
  }

  # Validate NSG references
  validate_nsg_keys = {
    valid_nsg_keys = (
      try(length(var.settings.subnet_settings.subnets) > 0, false) 
      ? { 
          for key, subnet in var.settings.subnet_settings.subnets : 
          key => (
            try(subnet.nsg_key, null) != null && !try(contains(keys(var.settings.network_security_group_settings), subnet.nsg_key), false)
            ? tobool("Error: NSG key ${subnet.nsg_key} for subnet ${key} is not defined in network_security_group_settings")
            : true
          )
        } 
      : {}
    )
  }

  # Validate route table references
  validate_rts_keys = {
    valid_rts_keys = (
      try(length(var.settings.subnet_settings.subnets) > 0, false) 
      ? { 
          for key, subnet in var.settings.subnet_settings.subnets : 
          key => (
            try(subnet.rts_key, null) != null && !try(contains(keys(var.settings.route_tables_settings), subnet.rts_key), false)
            ? tobool("Error: Route table key ${subnet.rts_key} for subnet ${key} is not defined in route_tables_settings")
            : true
          )
        } 
      : {}
    )
  }
}

# end
#--------------------------------------------*--------------------------------------------