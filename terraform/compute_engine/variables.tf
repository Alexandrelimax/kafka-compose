variable "compute_name" {
  description = "Nome da Compute Engine"
  type        = string
}

variable "machine_type" {
  description = "Tipo da Máquina"
  type        = string
}

variable "zone" {
  description = "Zona da Compute Engine"
  type        = string
}

variable "image" {
  description = "Imagem do SO da Compute Engine"
  type        = string
}

variable "vpc_network_id" {
  description = "ID da VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID da Subrede"
  type        = string
}

variable "startup_script" {
  description = "Script de inicialização"
  type        = string
  default     = ""
}
