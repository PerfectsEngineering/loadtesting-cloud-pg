output "db_host" {
    value = google_sql_database_instance.postgres.private_ip_address
}

output "db_port" {
    value = 5432
}

output "db_user_name" {
    value = google_sql_user.user.name
}

output "db_user_password" {
    value = google_sql_user.user.password
    sensitive = true
}

output "compute_public_ip" {
    value = google_compute_instance.runner.network_interface.0.access_config.0.nat_ip
}