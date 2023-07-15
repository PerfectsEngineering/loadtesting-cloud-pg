terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.73.1"
    }
  }
}

provider "google" {
  project     = var.gcp_project_id
  region      = var.region
}

provider "google-beta" {
  project     = var.gcp_project_id
  region      = var.region
}