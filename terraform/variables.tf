variable "project_id" {
  description = "ID do projeto no GCP"
  type        = string
}

variable "region" {
  description = "Região padrão"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona padrão"
  type        = string
  default     = "us-central1-a"
}


# Variável para o nome da VPC
variable "vpc_name" {
  description = "Nome da VPC a ser criada"
  type        = string
}

# Variável para o nome da Subrede
variable "subnet_name" {
  description = "Nome da subrede a ser criada na VPC"
  type        = string
}

# Variável para o intervalo CIDR da subrede
variable "cidr_range" {
  description = "Faixa CIDR da subrede"
  type        = string
}

# Variável para a região
variable "region" {
  description = "Região onde os recursos serão criados"
  type        = string
}

# Variável para o nome da instância Compute Engine
variable "compute_name" {
  description = "Nome da instância Compute Engine"
  type        = string
}

# Variável para o tipo da máquina Compute Engine
variable "machine_type" {
  description = "Tipo da máquina Compute Engine (ex: e2-medium)"
  type        = string
}

# Variável para a zona
variable "zone" {
  description = "Zona onde os recursos Compute Engine serão criados"
  type        = string
}

# Variável para a imagem do sistema operacional
variable "image" {
  description = "Imagem do sistema operacional da Compute Engine"
  type        = string
}

# Variável para o nome do cluster Dataproc
variable "cluster_name" {
  description = "Nome do cluster Dataproc"
  type        = string
}

# Variável para o tipo de máquina Master no Dataproc
variable "master_machine_type" {
  description = "Tipo da máquina Master no cluster Dataproc"
  type        = string
}

# Variável para o tipo de máquina Worker no Dataproc
variable "worker_machine_type" {
  description = "Tipo da máquina Worker no cluster Dataproc"
  type        = string
}

# Variável para o número de Workers no Dataproc
variable "num_workers" {
  description = "Número de Workers no cluster Dataproc"
  type        = number
}
