terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.75.1"
    }

    google-beta = {
      source = "hashicorp/google-beta"
      version = "4.75.1"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
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