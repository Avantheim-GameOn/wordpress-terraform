resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.wp_sg.id]
  associate_public_ip_address = true
  key_name = var.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = file("${path.module}/install_wordpress.sh")

  tags = {
    Name = "${var.project_name}-wordpress-${var.instance_name}"
  }
}
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "${var.project_name}-ec2-cw-role-${var.instance_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_cw_attach" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-profile-${var.instance_name}"
  role = aws_iam_role.ec2_cloudwatch_role.name
}
