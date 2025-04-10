variable "project_name" {
  description = "Prefixo comum para nomear os recursos"
  type        = string
}

variable "instance_name" {
  description = "Identificador único para distinguir instâncias (ex: blue ou green)"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde a instância será criada"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet pública para associar à instância"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "ami_id" {
  description = "AMI usada para lançar a instância"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH associada à instância"
  type        = string
}