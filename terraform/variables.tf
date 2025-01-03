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



# VPC
variable "network_name" {
  description = "Nome da VPC a ser criada"
  type        = string
}

variable "subnets" {
  description = "Lista de sub-redes a serem criadas."
  type = list(object({
    name                     = string
    cidr                     = string
    region                   = string
    private_ip_google_access = bool
  }))
}

#FIREWALL
variable "firewall_name" {
  description = "Nome da regra de firewall"
  type        = string
}

variable "network" {
  description = "Nome da rede onde a regra de firewall será aplicada"
  type        = string
  default     = "default" # Rede padrão
}

variable "allowed_ports" {
  description = "Lista de portas permitidas pela regra de firewall"
  type        = list(string)
}

variable "source_ranges" {
  description = "Faixas de IP que podem acessar as portas liberadas"
  type        = list(string)
}

variable "firewall_tags" {
  description = "Tags associadas à regra de firewall"
  type        = list(string)
}






# Compute Engine
variable "compute_name" {
  description = "Nome da instância Compute Engine"
  type        = string
}

variable "machine_type" {
  description = "Tipo da máquina Compute Engine (ex: e2-medium)"
  type        = string
}

variable "zone" {
  description = "Zona onde os recursos Compute Engine serão criados"
  type        = string
}

variable "image" {
  description = "Imagem do sistema operacional da Compute Engine"
  type        = string
}
variable "ssh_username" {
  description = "Nome do usuário para o acesso SSH"
  type        = string
}
variable "ssh_public_key_path" {
  description = "Caminho para a chave pública SSH"
  type        = string
}
variable "startup_script_path" {
  description = "Caminho para a chave pública SSH"
  type        = string
}


# cluster Dataproc
variable "cluster_name" {
  description = "Nome do cluster Dataproc"
  type        = string
}


variable "master_machine_type" {
  description = "Tipo da máquina Master no cluster Dataproc"
  type        = string
}


variable "worker_machine_type" {
  description = "Tipo da máquina Worker no cluster Dataproc"
  type        = string
}

variable "num_workers" {
  description = "Número de Workers no cluster Dataproc"
  type        = number
}
