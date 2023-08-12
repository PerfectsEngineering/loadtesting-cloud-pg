output "db_host" {
    value = heroku_addon.database.config_var_values.DATABASE_URL
    sensitive = true
}

# output "db_port" {
#     value = 5432
# }