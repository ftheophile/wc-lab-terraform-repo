provider "aws" {
  region  = var.dev-region
  profile = "default"
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
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.org_name} production vpc"
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


#Associate SUBNET with Route Table

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.prod-route-table.id

}

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = module.ec2server1.first_server_id
#   allocation_id = aws_eip.one.id
# }
