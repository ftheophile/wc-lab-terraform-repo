provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_instance" "server" {
  #count = 4 # create four similar EC2 instances
  for_each = tomap({
    Dev = { x1 = "t2.nano", name = "Development", os = "ami-04cb4ca688797756f" },

    Prod = { x1 = "t2.micro", name = "Production", os = "ami-04cb4ca688797756f" },

    Staging = { x1 = "t2.small", name = "Staging", os = "ami-04cb4ca688797756f" },

    QA = { x1 = "t3.micro", name = "Quality Assurance", os = "ami-04cb4ca688797756f" }
  })
  #for_each = toset(["t2.nano", "t2.micro", "t3.micro", "t3.small"])

  ami           = each.value.os
  instance_type = each.value.x1

  tags = {
    Name = "Server ${each.value.name}"
  }
}