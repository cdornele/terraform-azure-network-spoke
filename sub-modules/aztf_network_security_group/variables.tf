#--------------------------------------------*--------------------------------------------
#  Sub-Module: Azure Network Security Groups - Variables
#--------------------------------------------*--------------------------------------------

variable "settings" {
  description = "Map of settings for the network security group"
}

variable "resource_group" {
  description = "The name of the resource group in which the network security group will be created"
  type        = string
}

variable "location" {
  description = "The location/region where the network security group will be created"
  type        = string
} 

variable "subnets" {
  description = "Map of subnets to create network security groups for"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}


# end
#--------------------------------------------*--------------------------------------------