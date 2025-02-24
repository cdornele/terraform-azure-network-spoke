#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Route Table - Variables
#--------------------------------------------*--------------------------------------------

variable "settings" {
  description = "Map of settings for the route table"
}

variable "resource_group" {
  description = "The name of the resource group in which the route table will be created"
  type        = string
}

variable "location" {
  description = "The location/region where the route table will be created"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create route tables for"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

# end
#--------------------------------------------*--------------------------------------------