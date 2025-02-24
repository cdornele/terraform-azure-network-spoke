#--------------------------------------------*--------------------------------------------
# Sub-Module: Azure Route Table - Versions
#--------------------------------------------*--------------------------------------------

terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 4.10.0"
    }
  }
}

# end
#--------------------------------------------*--------------------------------------------
