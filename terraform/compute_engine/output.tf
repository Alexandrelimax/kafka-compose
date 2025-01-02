output "compute_instance_name" {
  description = "Nome da Compute Engine"
  value       = google_compute_instance.compute_instance.name
}

output "compute_instance_ip" {
  description = "Endereço IP da Compute Engine"
  value       = google_compute_instance.compute_instance.network_interface.0.access_config.0.nat_ip
}
