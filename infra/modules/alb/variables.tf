variable "project_name" {
  description = "Nome do projeto para tagueamento"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde será criado o Load Balancer"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de subnets públicas para associar ao ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "ID do Security Group do ALB"
  type        = string
}

variable "blue_instance_id" {
  description = "Instance ID da instância EC2 Blue"
  type        = string
}

variable "green_instance_id" {
  description = "Instance ID da instância EC2 Green"
  type        = string
}
