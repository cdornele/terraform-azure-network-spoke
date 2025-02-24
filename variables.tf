#--------------------------------------------*--------------------------------------------
# Module: Azure Vritual Network Spoke - Variables
#--------------------------------------------*--------------------------------------------

variable "global_settings" {
  description = "Global settings for the module"
}

variable "location" {
  description = "The location/region where the virtual network is created"
  type = string
}

variable "resource_group" {
  description = "The name of the resource group in which the virtual network is created"
  type = string
}

variable "settings" {
  description = "Settings for the virtual network"
}

variable "tags" {
  description = "A map of tags to add to all resources"
}

# end
#--------------------------------------------*--------------------------------------------