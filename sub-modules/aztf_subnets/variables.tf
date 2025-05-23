#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Subnet - Variables
#--------------------------------------------*--------------------------------------------

variable "settings" {
  description = "Map of settings for the subnet"
  type        = any
}

variable "resource_group" {
  description = "The name of the resource group in which the subnet will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network in which the subnet will be created"
  type        = string
}

# end
#--------------------------------------------*--------------------------------------------