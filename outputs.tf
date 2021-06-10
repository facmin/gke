output "region" {
  value       = var.region
  description = "Region de Google Cloud"
}

output "zone" {
  value       = var.zone
  description = "Zona de Google Cloud"
}

output "project_id" {
  value       = var.project_id
  description = "Identificador de Proyecto Google Cloud"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Nombre de Cluster de GKE"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "IP de Cluster de GKE"
}
