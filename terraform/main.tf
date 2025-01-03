provider "google" {
  project = var.project_id
  region  = var.region
}

module "firewall" {
  source = "./modules/firewall"

  firewall_name = var.firewall_name
  network       = var.network
  allowed_ports = var.allowed_ports
  source_ranges = var.source_ranges
  target_tags   = var.firewall_tags
}

module "compute_instance" {
  source = "./modules/compute"

  compute_name        = var.compute_name
  machine_type        = var.machine_type
  zone                = var.zone
  image               = var.image
  network             = var.network
  firewall_tags       = module.firewall.firewall_tags
  startup_script      = var.startup_script_path

  ssh_username        = var.ssh_username
  ssh_public_key_path = var.ssh_public_key_path
}


module "dataproc" {
  source               = "./modules/dataproc"
  cluster_name         = var.cluster_name
  region               = var.region
  master_machine_type  = var.master_machine_type
  worker_machine_type  = var.worker_machine_type
  num_workers          = var.num_workers
  subnet_id            = module.vpc.subnet_id
}
