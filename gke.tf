variable "gke_username" {
  default     = ""
  description = "Nombre de Usuario GKE"
}

variable "gke_password" {
  default     = ""
  description = "Contraseña de GKE"
}

variable "gke_num_nodes" {
  default     = 1
  description = "Cantidad de Nodos de GKE (Workers)"
}

# Definición de Cluster GKE

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  # Importante para usar capa gratuita - Solo para pruebas
  location = var.zone

  # Alta Disponibilidad de GKE - Crearla como regional
  # location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  master_auth {
    username = var.gke_username
    password = var.gke_password

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Administración de nodos (Workers)

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  # Importante para usar capa gratuita - Solo para pruebas
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # Imagen minima para prueba
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
