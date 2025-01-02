resource "google_compute_instance" "compute_instance" {
  name         = var.compute_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.vpc_network_id
    subnetwork = var.subnet_id
    access_config {} # Necessário para IP público
  }

  metadata_startup_script = var.startup_script
}
