output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "public_ip_blue" {
  value = module.ec2_blue.public_ip
}

output "public_ip_green" {
  value = module.ec2_green.public_ip
}

output "alb_dns_name" {
  description = "DNS público do Application Load Balancer"
  value       = module.alb.alb_dns_name
}
