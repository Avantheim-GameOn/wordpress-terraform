output "alb_dns_name" {
  description = "DNS público do Load Balancer"
  value       = aws_lb.wordpress_alb.dns_name
}
