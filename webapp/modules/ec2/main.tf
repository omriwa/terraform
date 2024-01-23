variable "ami" {
}

variable "instance_type" {
}

variable "instances_name" {
}

variable "sg_name" {

}

resource "aws_instance" "instance" {
  for_each        = var.instances_name
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [var.sg_name]
  user_data       = <<-EOF
                #!/bin/bash
                echo "Hello, World ${each.key}" > index.html
                python3 -m http.server 8080 &
                EOF

  tags = {
    Name = each.key
  }
}
