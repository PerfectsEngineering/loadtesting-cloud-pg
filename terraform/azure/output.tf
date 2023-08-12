output "db_host" {
    value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "db_port" {
    value = 5432
}

output "db_user_name" {
    value = azurerm_postgresql_flexible_server.postgres.administrator_login
}

output "db_user_password" {
    value = azurerm_postgresql_flexible_server.postgres.administrator_password
    sensitive = true
}

output "compute_public_ip" {
    value = azurerm_public_ip.runner_public_ip.ip_address
}

output "compute_ssh_user" {
    value = azurerm_linux_virtual_machine.runner.admin_username
}