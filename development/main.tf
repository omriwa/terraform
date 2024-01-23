terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = var.environment
}


module "webapp" {
  source = "../webapp"

  environment = var.environment
}
