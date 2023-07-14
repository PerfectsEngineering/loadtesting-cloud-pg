output "do_db_host" {
    value = digitalocean_database_cluster.postgres.private_host
}

output "do_db_port" {
    value = digitalocean_database_cluster.postgres.port
}

output "do_db_user_password" {
    value = digitalocean_database_user.loadtest.password
    sensitive = true
}

output "do_droplet_public_ip" {
    value = digitalocean_droplet.runner.ipv4_address
}