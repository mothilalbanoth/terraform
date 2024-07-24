provider "aws" {

  region = "ap-south-1"

}
 
resource "aws_s3_bucket" "s3-storage" {

  bucket = "bucketmothilal12334"
 
  tags = {

    Name = "s3-storage"

  }

}
 
resource "aws_s3_bucket_versioning" "s3-storage-versioning" {

  bucket = aws_s3_bucket.s3-storage.id

  versioning_configuration {

    status = "Enabled"

  }

}
 
resource "aws_s3_bucket_lifecycle_configuration" "prod-env-9949-lifecycle" {

  bucket = aws_s3_bucket.s3-storage.id
 
  rule {

    id      = "s3-bucket-rule"

    status  = "Enabled"
 
    noncurrent_version_expiration {

      noncurrent_days = 90

    }

  }

}

 
