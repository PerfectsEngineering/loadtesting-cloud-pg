output "db_host" {
    value = digitalocean_database_cluster.postgres.private_host
}

output "db_port" {
    value = digitalocean_database_cluster.postgres.port
}

output "db_user_name" {
    value = digitalocean_database_cluster.postgres.user
}

output "db_user_password" {
    value = digitalocean_database_cluster.postgres.password
    sensitive = true
}

output "compute_public_ip" {
    value = digitalocean_droplet.runner.ipv4_address
}

output "compute_ssh_user" {
    value = "root"
}