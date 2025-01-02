#VPC
vpc_name            = "minha-vpc"
subnet_name         = "minha-subrede"
cidr_range          = "10.0.0.0/16"
region              = "us-central1"

#COMPUTE-ENGINE
compute_name        = "minha-compute-instance"
machine_type        = "e2-medium"
zone                = "us-central1-a"
image               = "projects/debian-cloud/global/images/family/debian-11"

#DATAPROC
cluster_name        = "meu-cluster-dataproc"
master_machine_type = "n1-standard-4"
worker_machine_type = "n1-standard-2"
num_workers         = 2