resource "azurerm_virtual_network" "vpc" {
  name                = "loadtest_vpc"
  address_space       = ["10.7.0.0/16"]
  location            = azurerm_resource_group.loadtest.location
  resource_group_name = azurerm_resource_group.loadtest.name
}

resource "azurerm_private_dns_zone" "database_dns_zone" {
  name                = "loadtest.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.loadtest.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "database_dns_zone_link" {
  name                  = "loadtest_link.com"
  private_dns_zone_name = azurerm_private_dns_zone.database_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vpc.id
  resource_group_name   = azurerm_resource_group.loadtest.name
}

resource "azurerm_subnet" "database_subnet" {
  name                 = "loadtest_db_subnet"
  resource_group_name  = azurerm_resource_group.loadtest.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = ["10.7.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "runner_subnet" {
  name                 = "runner_subnet"
  resource_group_name  = azurerm_resource_group.loadtest.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = ["10.7.2.0/24"]
}
