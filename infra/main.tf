module "vpc" {
  source              = "./modules/vpc"
  project_name        = "goncalo-wp"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  public_subnet_cidr_2 = "10.0.2.0/24"
  az                  = "eu-west-1a"
}

module "ec2_blue" {
  source         = "./modules/ec2"
  project_name   = "goncalo-wp"
  instance_name  = "blue"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
  instance_type  = "t2.micro"
  ami_id         = "ami-0c1c30571d2dae5c9"  # Ubuntu Server 22.04 LTS (eu-west-1)
  key_name       = "goncalo-key"
  security_group_id  = module.security_groups.security_group_id
}

module "ec2_green" {
  source         = "./modules/ec2"
  project_name   = "goncalo-wp"
  instance_name  = "green"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id_2
  instance_type  = "t2.micro"
  ami_id         = "ami-0c1c30571d2dae5c9"  # Ubuntu Server 22.04 LTS (eu-west-1)
  key_name       = "goncalo-key"
  security_group_id  = module.security_groups.security_group_id
}

resource "aws_db_subnet_group" "wordpress_subnet_group" {
  name       = "goncalo-wp-subnet-group"
  subnet_ids = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_2]

  tags = {
    Name = "goncalo-wp-subnet-group"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "goncalo-wp-db-sg"
  description = "Allow MySQL traffic from WordPress EC2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.security_groups.security_group_id]


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "goncalo-wp-db-sg"
  }

  lifecycle {
  prevent_destroy = true
  }
}

module "rds" {
  source           = "./modules/rds"
  project_name     = "goncalo-wp"
  db_name          = "wordpress"
  db_user          = "admin"
  db_password      = "Wordpress123!"
  db_subnet_group  = aws_db_subnet_group.wordpress_subnet_group.name
  db_sg_id         = aws_security_group.db_sg.id
}

module "monitoring" {
  source         = "./modules/monitoring"
  instance_id    = module.ec2_blue.instance_id
  project_name   = "goncalo-wp-blue"
}

module "monitoring_green" {
  source         = "./modules/monitoring"
  instance_id    = module.ec2_green.instance_id
  project_name   = "goncalo-wp-green"
}

resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security Group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

module "alb" {
  source             = "./modules/alb"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_2]
  alb_sg_id          = aws_security_group.alb_sg.id
  blue_instance_id  = module.ec2_blue.instance_id
  green_instance_id = module.ec2_green.instance_id
}

module "git_user" {
  source = "./modules/IAM"
  name = "git_user"
  policy_arns                   = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess","arn:aws:iam::aws:policy/AmazonRDSFullAccess","arn:aws:iam::aws:policy/AmazonS3FullAccess","arn:aws:iam::aws:policy/AmazonVPCFullAccess","arn:aws:iam::aws:policy/CloudWatchFullAccess","arn:aws:iam::aws:policy/IAMFullAccess"]
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}
