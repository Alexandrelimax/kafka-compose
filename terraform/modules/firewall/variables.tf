variable "firewall_name" {
  description = "Nome da regra de firewall."
  type        = string
}

variable "network" {
  description = "Rede onde a regra de firewall será aplicada."
  type        = string
}

variable "allowed_ports" {
  description = "Lista de portas a serem permitidas."
  type        = list(string)
}

variable "source_ranges" {
  description = "Faixas de IP que podem acessar as portas permitidas."
  type        = list(string)
}

variable "target_tags" {
  description = "Tags de destino para aplicar a regra."
  type        = list(string)
}
