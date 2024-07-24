provider "aws" {
  region = "ap-south-1"
}
 
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "mothi703"
}
 
resource "aws_s3_bucket_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.id
  source = "./myfile.txt"
  key    = "mydata.txt"
}
