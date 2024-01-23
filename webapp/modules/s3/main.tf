resource "aws_s3_bucket" "application-s3" {
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "bucket_versions" {
  bucket = aws_s3_bucket.application-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.application-s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
