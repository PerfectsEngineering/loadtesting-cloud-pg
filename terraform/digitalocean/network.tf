resource "digitalocean_vpc" "vpc" {
  name     = "loadtest-network"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_database_firewall" "postgres-firewall" {
  cluster_id = digitalocean_database_cluster.postgres.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.runner.id
  }
}