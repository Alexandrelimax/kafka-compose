module "vpc" {
  source       = "./modules/vpc"
  vpc_name     = vpc_name
  subnet_name  = var.subnet_name
  cidr_range   = var.cidr_range
  region       = var.region
}

module "compute_engine" {
  source           = "./modules/compute_engine"
  compute_name     = var.compute_name
  machine_type     = var.machine_type
  zone             = var.zone
  image            = var.image
  vpc_network_id   = module.vpc.vpc_network_id
  subnet_id        = module.vpc.subnet_id
  startup_script   = file("compute_engine/scripts/init-docker.sh")
  depends_on       = [null_resource.set_permissions]
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
