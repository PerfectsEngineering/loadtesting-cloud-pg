# NOTE: I realized Heroku uses AWS Machines for its database.
# So, I'm won't be proceeding with Heroku again.

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "5.2.5"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource random_id "app_suffix" {
  byte_length = 4
}

provider "heroku" {
  api_key = var.heroku_api_key
}

resource "heroku_app" "dummy_app" {
  name = "dummy-load-app-${random_id.app_suffix.hex}"
  region = var.region
}

resource "heroku_addon" "database" {
  app_id = heroku_app.dummy_app.id
  // 8GB RAM, CPU Unknown, 256GB Storage
  plan   = "heroku-postgresql:standard-2"
}
