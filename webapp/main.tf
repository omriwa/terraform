terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
      profile = var.environment
}

module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "security_group" {
  source = "./modules/securityGroup"
}


module "ec2" {
  source = "./modules/ec2"

  instances_name = var.instances_name
  ami            = var.ami
  instance_type  = var.instance_type
  sg_name        = module.security_group.sg.name
}

module "load_balancer" {
  source = "./modules/loadBalancer"

  instances = module.ec2.instances
  vpc       = module.vpc.vpc
  alb_sg    = module.security_group.alb_sg
  subnets   = [module.vpc.subnet-1a.id, module.vpc.subnet-1b.id]
}


module "db" {
  source = "./modules/db"

  s3_bucket = module.s3.s3_bucket
}




