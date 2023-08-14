terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.75.1"
    }

    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }

    vultr = {
      source = "vultr/vultr"
      version = "2.15.1"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
}