provider "aws" {
  region  = var.dev-region
  profile = "default"
}


module "ec2server1" {
  source      = "git::https://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@github.com/ftheophile/terraform-modules.git//ec2server"
  org_name    = "${var.org_name} Production instance"
  environment = var.environment
  purpose     = var.purpose
  subnetid    = aws_subnet.app-subnet.id
  ec2az       = var.dev_az[0]
  sec_group   = module.secgroup1.allow_web_sgid #aws_security_group.allow_web.id
  eipid       = aws_eip.one.id
}

module "instance2" {
  source      = "git::https://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@github.com/ftheophile/terraform-modules.git//ec2server"
  org_name    = "${var.org_name} Development instance"
  environment = var.environment
  purpose     = var.purpose
  subnetid    = aws_subnet.db-subnet.id
  ec2az       = var.dev_az[1]
  sec_group   = module.secgroup1.allow_web_sgid # aws_security_group.allow_web.id
  eipid       = aws_eip.two.id
  instancetype = "t3.micro"
}

module "ec2_instance4" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  version = "5.5.0"

  for_each = toset(["one", "two", "three"])

  name = "wc-instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "UsualKeyPairPPk"
  monitoring             = true
  vpc_security_group_ids = [module.secgroup1.allow_web_sgid]
  subnet_id              = aws_subnet.db-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "var.environment"
  }
}

module "secgroup1" {
  source = "git::https://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@github.com/ftheophile/terraform-modules.git//secgroup"
  vpcid = aws_vpc.prod.id
}
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

resource "aws_subnet" "app-subnet" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.dev_az[0]

  tags = {
    Name = "${var.org_name} application subnet"
  }
}

resource "aws_subnet" "db-subnet" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.dev_az[1]

  tags = {
    Name = "${var.org_name} database subnet"
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

resource "aws_eip" "one" {
  domain = "vpc"
  # network_interface = aws_network_interface.nic.id
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "two" {
  domain = "vpc"
  # network_interface = aws_network_interface.nic.id
  depends_on = [aws_internet_gateway.gw]
}
