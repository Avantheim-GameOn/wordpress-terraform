output "public_ip" {
  value = aws_instance.wordpress.public_ip
}
output "iam_instance_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}
