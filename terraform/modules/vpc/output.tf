output "vpc_network_name" {
  description = "Nome da VPC criada"
  value       = google_compute_network.vpc_network.name
}

output "subnetwork_names" {
  description = "Lista de nomes das sub-redes criadas"
  value       = google_compute_subnetwork.subnetwork[*].name
}

output "subnetwork_ids" {
  description = "Lista de IDs das sub-redes criadas"
  value       = google_compute_subnetwork.subnetwork[*].id
}