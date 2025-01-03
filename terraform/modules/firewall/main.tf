resource "google_compute_firewall" "firewall_rule" {
  name    = var.firewall_name
  network = var.network

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.source_ranges

  target_tags = var.target_tags
}
