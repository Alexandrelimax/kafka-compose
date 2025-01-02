provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Versão do provedor
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}
