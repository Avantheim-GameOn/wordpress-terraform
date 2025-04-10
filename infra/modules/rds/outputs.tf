output "db_endpoint" {
  description = "Endpoint da instância RDS MySQL"
  value       = aws_db_instance.wordpress_db.endpoint
}
