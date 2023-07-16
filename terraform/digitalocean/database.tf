resource "digitalocean_database_cluster" "postgres" {
  name       = "loadtest-postgres-cluster"
  engine     = "pg"
  version    = "15"
  size       = "gd-4vcpu-16gb"
  region     = var.region
  node_count = 1
  private_network_uuid = digitalocean_vpc.vpc.id
}

resource "digitalocean_database_db" "loadtest" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "loadtest"
}