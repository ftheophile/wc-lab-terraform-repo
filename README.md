resource "aws_s3_bucket" "wirfoncloud-bucket" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "ambi"
    Environment = "Dev"
  }
}
