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
