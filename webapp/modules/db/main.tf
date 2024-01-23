variable "s3_bucket" {

}


resource "aws_db_instance" "db_instance" {
  allocated_storage   = 10
  storage_type        = "standard"
  engine              = "postgres"
  engine_version      = "16"
  instance_class      = "db.t3.micro"
  username            = "test"
  password            = "test-password"
  skip_final_snapshot = true
  deletion_protection = false
  depends_on          = [var.s3_bucket]
}
