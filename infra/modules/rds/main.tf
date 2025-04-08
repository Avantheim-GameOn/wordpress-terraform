resource "aws_db_instance" "wordpress_db" {
  identifier           = "${var.project_name}-db"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true
  db_subnet_group_name = var.db_subnet_group
  vpc_security_group_ids = [var.db_sg_id]

  tags = {
    Name = "${var.project_name}-rds"
  }
}
