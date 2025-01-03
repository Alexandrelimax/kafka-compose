variable "network_name" {
  description = "O nome da rede VPC."
  type        = string
  default     = "my-vpc-network"
}

variable "subnets" {
  description = "Lista de sub-redes a serem criadas."
  type = list(object({
    name                      = string
    cidr                      = string
    region                    = string
    private_ip_google_access  = bool
  }))
}