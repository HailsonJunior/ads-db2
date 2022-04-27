data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "azurerm_mysql_server" "db2_mysql_server" {
  name                = "db2-mysql-server"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.ads_resource_group.name

  administrator_login          = "linuxtux"
  administrator_login_password = "ads123@@"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "db2_mysql_database" {
  name                = "adsdatabase"
  resource_group_name = azurerm_resource_group.ads_resource_group.name
  server_name         = azurerm_mysql_server.db2_mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "db_firewall" {
  name                = "ads"
  resource_group_name = azurerm_resource_group.ads_resource_group.name
  server_name         = azurerm_mysql_server.db2_mysql_server.name
  start_ip_address    = chomp(data.http.myip.body)
  end_ip_address      = chomp(data.http.myip.body)
}
