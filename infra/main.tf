provider "aws" {
  region = "eu-west-1" # Irlanda (Free Tier disponível)
}

module "vpc" {
  source              = "./modules/vpc"
  project_name        = "goncalo-wp"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  az                  = "eu-west-1a"
}

module "ec2" {
  source         = "./modules/ec2"
  project_name   = "goncalo-wp"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_id
  instance_type  = "t2.micro"
  ami_id         = "ami-00410d8a184b40e78"  # << atualizado
  key_name       = "goncalo-key"
}
