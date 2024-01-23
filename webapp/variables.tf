variable "ami" {
  type    = string
  default = "ami-025a6a5beb74db87b"
}

variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "instances_name" {
  type    = set(string)
  default = ["instance_1", "instance_2"]
}

variable "environment" {
  type    = string
  default = "default"
}
