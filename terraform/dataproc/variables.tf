variable "cluster_name" {
  description = "Nome do Cluster Dataproc"
  type        = string
}

variable "region" {
  description = "Região do Cluster"
  type        = string
}

variable "master_machine_type" {
  description = "Tipo da máquina master"
  type        = string
}

variable "worker_machine_type" {
  description = "Tipo das máquinas worker"
  type        = string
}

variable "num_workers" {
  description = "Número de workers"
  type        = number
}

variable "subnet_id" {
  description = "ID da Subrede"
  type        = string
}
