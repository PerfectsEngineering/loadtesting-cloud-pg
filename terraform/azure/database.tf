resource "random_id" "user_password" {
  byte_length = 8
}

resource "random_id" "database_suffix" {
  byte_length = 8
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  # name must be unique across all of Azure
  name                   = "loadtest-pg-${random_id.database_suffix.hex}"
  resource_group_name    = azurerm_resource_group.loadtest.name
  location               = azurerm_resource_group.loadtest.location

  version                = "15"

  private_dns_zone_id = azurerm_private_dns_zone.database_dns_zone.id
  delegated_subnet_id    = azurerm_subnet.database_subnet.id

  administrator_login          = "loadtest_user"
  administrator_password = random_id.user_password.hex
  
  storage_mb = 65536

  sku_name   = "GP_Standard_D4s_v3" // 4 vCPU, 20.8 GB RAM

  depends_on = [ azurerm_private_dns_zone_virtual_network_link.database_dns_zone_link ]

  lifecycle {
    ignore_changes = [ 
      zone,
      high_availability[0].standby_availability_zone,
     ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "postgres" {
  name      = "loadtest"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  collation = "en_US.utf8"
  charset   = "utf8"
}