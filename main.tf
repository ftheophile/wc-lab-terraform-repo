provider "aws" {
  region              = "us-east-1"
  profile             = "default"
}

resource "aws_instance" "my-first-server" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  tags = {
    Name = "Ubuntu"
  }

}

resource "aws_s3_bucket" "_dev_bucket" {
  bucket = "yvebuket2012"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}