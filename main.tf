provider "aws" {
  region              = "us-east-1a"
  profile             = "default"
}


resource "aws_instance" "my-first-server" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.app-subnet.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "Ubuntu"
  
  }

}

#resource "aws_s3_bucket" "_dev_bucket" {
#  bucket = "yvebuket2012"

 # tags = {
#    Name        = "My bucket"
 #   Environment = "Dev"
#  }
#}

# Create a VPC
resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"
 

  tags = {
    Name = "production"
  }
}

#Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "gw"
  }
}

#create a Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "prod"

  }
}
#Create Subnet

resource "aws_subnet" "app-subnet" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "application"
  }
}
resource "aws_subnet" "db-subnet" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a" 

  tags = {
    Name = "database"
