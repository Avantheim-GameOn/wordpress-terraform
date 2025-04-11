output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.wordpress.id
}

output "public_ip" {
  description = "Endereço IP público da instância EC2"
  value       = aws_instance.wordpress.public_ip
}
