output "db_host" {
  # value = vultr_bare_metal_server.pg_server.main_ip
  value = vultr_instance.pg_server.main_ip
}

output "db_port" {
  value = 5432
}

output "db_user_name" {
  value = "postgres"
}

output "db_user_password" {
  value     = "postgres-pass"
  sensitive = true
}

output "compute_public_ip" {
  value = vultr_instance.runner.main_ip
}

output "compute_ssh_user" {
  value = "root"
}