variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}

variable "subnet_name" {
  description = "Nome da Subrede"
  type        = string
}

variable "cidr_range" {
  description = "CIDR da Subrede"
  type        = string
}

variable "region" {
  description = "Região da VPC"
  type        = string
}
