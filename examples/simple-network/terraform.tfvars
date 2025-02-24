#--------------------------------------------*--------------------------------------------
# Example - Simple Azure Virtual Network Spoke
#--------------------------------------------*--------------------------------------------

settings = {
  global_settings = {
    name = "example"
    prefixes = ["az","eus"]
    suffixes = ["d", "01"]
  }
    network = {
        address_space       = ["192.168.0.0/24"]
        dns_servers_enabled = true
        dns_servers_list    = ["8.8.8.8","1.1.1.1"]
        subnet_settings     = {
            subnets = {
                application = {
                    name = "app"
                    prefixes = ["az","eus"]
                    suffixes = ["d", "01"]
                    address_prefixes = ["192.168.0.0/28"]
                    nsg_key = "application-nsg"
                    rts_key = "application-rts"
                }
                data = {
                    name = "data"
                    prefixes = ["az","eus"]
                    suffixes = ["d", "01"]
                    address_prefixes = ["192.168.0.16/28"]
                    nsg_key = "data-nsg"
                    rts_key = "data-rts"
                }
            }
        }
        network_security_group_settings = {
          empty_nsg={}
          application-nsg={
            name     ="app"
            prefixes = ["az","eus"]
            suffixes = ["d", "01"]
            tags     = {
               nsg_definition = "application_nsg"
            }
            rules    = [
              {
                name                       = "example-inbound-rule-allow-http-https",
                priority                   = "100"
                direction                  = "Inbound"
                access                     = "Allow"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_ranges    = ["443","80"]
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                description                = "Allow inbound HTTP traffic example"
              },
              {
                name                         = "example-inbound-rule-allow-data-subnet",
                priority                     = "200"
                direction                    = "Inbound"
                access                       = "Allow"
                protocol                     = "Tcp"
                source_port_range            = "*"
                destination_port_range       = "*"
                source_address_prefixes      = ["192.168.0.16/28"]
                destination_address_prefixes = ["192.168.0.0/28"]
                description                  = "Allow inbound data subnet traffic example"
              },
              {
                name                       = "example-inbound-rule-deny-all",
                priority                   = "4000"
                direction                  = "Inbound"
                access                     = "Deny"
                protocol                   = "*"
                source_port_range          = "*"
                destination_port_range     = "*"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                description                = "Deny all inbound traffic example"
              },

              {
                name                       = "example-outbound-rule",
                priority                   = "100"
                direction                  = "Outbound"
                access                     = "Allow"
                protocol                   = "*"
                source_port_range          = "*"
                destination_port_ranges    = ["443","80"]
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                description                = "Allow outbound traffic example"
              },
            ]
          }
          data-nsg={
            name     ="data"
            prefixes = ["az","eus"]
            suffixes = ["d", "01"]
            tags     = {
               nsg_definition = "data_nsg"
            }
            rules    = [
              {
                name                         = "example-inbound-rule-allow-app-subnet",
                priority                     = "200"
                direction                    = "Inbound"
                access                       = "Allow"
                protocol                     = "Tcp"
                source_port_range            = "*"
                destination_port_range       = "*"
                source_address_prefixes      = ["192.168.0.0/28"]
                destination_address_prefixes = ["192.168.0.16/28"]
                description                  = "Allow inbound app subnet traffic example"
              },
              {
                name                       = "example-inbound-rule-deny-all",
                priority                   = "4000"
                direction                  = "Inbound"
                access                     = "Deny"
                protocol                   = "*"
                source_port_range          = "*"
                destination_port_range     = "*"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                description                = "Deny all inbound traffic example"
              },

              {
                name                       = "example-outbound-rule",
                priority                   = "100"
                direction                  = "Outbound"
                access                     = "Allow"
                protocol                   = "*"
                source_port_range          = "*"
                destination_port_ranges    = ["443","80"]
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                description                = "Allow outbound traffic example"
              },
            ]
          }
        }
        route_tables_settings = {
         empty_rts={}
         application-rts={
          is_Enabled = true
          name     ="app"
          prefixes = ["az","eus"]
          suffixes = ["d", "01"]
          tags     = {
            rts_definition = "application_rts"
          }
          rts      = [
                      {
                        name = "udr-to-firewall"
                        address_prefix = "0.0.0.0/0"
                        next_hop_type = "VirtualAppliance"
                        next_hop_in_ip_address = "10.0.0.10"
                      },
                      {
                          name = "udr-to-data-subnet"
                          address_prefix = "192.168.0.16/28"
                          next_hop_type = "VnetLocal"            
                      },
                      {
                          name = "udr-to-internet"
                          address_prefix = "AzureBackup"
                          next_hop_type = "Internet"
                      }
                    ]
        }
         data-rts={
          is_Enabled = true
          name     ="data"
          prefixes = ["az","eus"]
          suffixes = ["d", "01"]
          tags     = {
            rts_definition = "data_rts"
          }
          rts      = [
                      {
                        name = "udr-to-firewall"
                        address_prefix = "0.0.0.0/0"
                        next_hop_type = "VirtualAppliance"
                        next_hop_in_ip_address = "10.0.0.10"
                      },
                      {
                          name = "udr-to-application-subnet"
                          address_prefix = "192.168.0.0/28"
                          next_hop_type = "VnetLocal"            
                      },
                      {
                          name = "udr-to-internet"
                          address_prefix = "AzureBackup"
                          next_hop_type = "Internet"
                      }
                    ]
        }
      }
    }
    tags = {
        environment = "dev"
    }
}