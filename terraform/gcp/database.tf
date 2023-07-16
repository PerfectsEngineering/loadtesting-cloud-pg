resource "google_sql_database_instance" "postgres" {
  provider         = google-beta

  name             = "loadtest-postgres-cluster"
  database_version = "POSTGRES_15"
  region           = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-custom-4-16384"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc.id
      enable_private_path_for_google_cloud_services = true
    }
  }

  # only set because of we want to be able to tear this down easily
  deletion_protection = false
}

resource "random_id" "user_password" {
  byte_length = 6
}

resource "google_sql_user" "user" {
  name     = "loadtest_user"
  instance = google_sql_database_instance.postgres.name
  password = random_id.user_password.hex
}

resource "google_sql_database" "loadtest" {
  name     = "loadtest"
  instance = google_sql_database_instance.postgres.name

  depends_on = [google_sql_user.user]
}