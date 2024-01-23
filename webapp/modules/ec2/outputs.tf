output "instances" {
  value = { for index, instance in aws_instance.instance : index => instance }
}
