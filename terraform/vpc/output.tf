output "vpc_network_id" {
  description = "ID da VPC"
  value       = google_compute_network.vpc_network.id
}

output "subnet_id" {
  description = "ID da Subrede"
  value       = google_compute_subnetwork.subnet.id
}
