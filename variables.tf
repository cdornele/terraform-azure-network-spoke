#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Network Spoke - Variables
#--------------------------------------------*--------------------------------------------

variable "global_settings" {
  description = "Global settings for the module"
  type        = object({
    name           = optional(string)
    prefixes       = optional(list(string), [])
    suffixes       = optional(list(string), [])
    passthrough    = optional(bool, false)
    clean_input    = optional(bool, true)
    separator      = optional(string, "-")
    random_length  = optional(number, 0)
    random_seed    = optional(number, 1)
    use_slug       = optional(bool, true)
  })
}

variable "location" {
  description = "The location/region where the virtual network is created"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which the virtual network is created"
  type        = string
}

variable "settings" {
  description = "Settings for the virtual network"
  type        = any
  # Note: Full type definition omitted due to complexity, but this should be improved 
  # in future iterations as part of a refactoring effort
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

# end
#--------------------------------------------*--------------------------------------------