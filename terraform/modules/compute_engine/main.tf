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
  }

  metadata = {
    ssh-keys           = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
    startup-script     = file(var.startup_script_path)
  }

  tags = var.network_tags
  
}
