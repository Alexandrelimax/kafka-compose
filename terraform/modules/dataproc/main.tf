resource "google_dataproc_cluster" "dataproc_cluster" {
  name   = var.cluster_name
  region = var.region

  cluster_config {
    # Configuração do Master
    master_config {
      num_instances = 1
      machine_type  = var.master_machine_type
    }

    # Configuração dos Workers
    worker_config {
      num_instances = var.num_workers
      machine_type  = var.worker_machine_type
    }

    # Configuração de Rede
    gce_cluster_config {
      subnetwork = var.subnet_id
    }
  }
}
