resource "aws_default_vpc" "vpc" {

}

resource "aws_default_subnet" "default_subnet-1a" {
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_subnet-1b" {
  availability_zone = "eu-central-1b"
}
