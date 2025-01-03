variable "compute_name" {
  description = "Nome da instância de Compute Engine."
  type        = string
}

variable "machine_type" {
  description = "Tipo da máquina (ex.: n1-standard-4)."
  type        = string
}

variable "zone" {
  description = "Zona onde a instância será criada."
  type        = string
}

variable "image" {
  description = "Imagem do sistema operacional (ex.: debian-cloud/debian-11)."
  type        = string
}

variable "vpc_network_id" {
  description = "ID da rede VPC."
  type        = string
}

variable "subnet_id" {
  description = "ID da sub-rede onde a instância será criada."
  type        = string
}

variable "ssh_user" {
  description = "Usuário para acesso SSH."
  type        = string
}

variable "ssh_public_key_path" {
  description = "Caminho para a chave pública SSH."
  type        = string
}

variable "startup_script_path" {
  description = "Script de inicialização para configurar a instância."
  type        = string
}

variable "network_tags" {
  description = "Tags de rede para firewall e outras configurações."
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "E-mail da conta de serviço para a instância."
  type        = string
}
