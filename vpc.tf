variable "project_id" {
  description = "Identificador de Proyecto en GCP"
}

variable "region" {
  description = "Region donde vivirá la plataforma"
}

variable "zone" {
  description = "Zona donde vivirá la plataforma"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Redes
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "172.33.0.0/24"
}
