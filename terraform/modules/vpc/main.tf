resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

# Criar as sub-redes
resource "google_compute_subnetwork" "subnetwork" {
  count                    = length(var.subnets)
  name                     = var.subnets[count.index].name
  ip_cidr_range            = var.subnets[count.index].cidr
  region                   = var.subnets[count.index].region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = var.subnets[count.index].private_ip_google_access
}