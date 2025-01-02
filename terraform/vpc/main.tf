resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
