output "vpc" {
  value = aws_default_vpc.vpc
}


output "subnet-1a" {
  value = aws_default_subnet.default_subnet-1a
}

output "subnet-1b" {
  value = aws_default_subnet.default_subnet-1b
}
