
# module "ec2server1" {
#   source      = "./modules/ec2server"
#   org_name    = "${var.org_name} Production instance"
#   environment = var.environment
#   purpose     = var.purpose
#   subnetid    = aws_subnet.app-subnet.id
#   ec2az       = var.dev_az[0]
#   sec_group   = module.secgroup1.allow_web_sgid #aws_security_group.allow_web.id
#   eipid       = aws_eip.one.id
# }

# module "instance2" {
#   source      = "./modules/ec2server"
#   org_name    = "${var.org_name} Development instance"
#   environment = var.environment
#   purpose     = var.purpose
#   subnetid    = aws_subnet.db-subnet.id
#   ec2az       = var.dev_az[1]
#   sec_group   = module.secgroup1.allow_web_sgid # aws_security_group.allow_web.id
#   eipid       = aws_eip.two.id
#   instancetype = "t3.micro"
# }

module "ec2server1" {
  source      = "git::https://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@github.com/ftheophile/terraform-modules.git//ec2server"
  for_each = toset(["one", "two", "three", "four", "five"])
  org_name    = "${var.org_name} Production ${each.key} instance"
  environment = var.environment
  purpose     = var.purpose
  subnetid    = aws_subnet.app-subnet.id
  ec2az       = var.dev_az[0]
  sec_group   = module.secgroup1.allow_web_sgid #aws_security_group.allow_web.id
  eipid       = aws_eip.eips[each.key].id
}

# module "instance2" {
#   source      = "git::https://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@github.com/ftheophile/terraform-modules.git//ec2server"
#   org_name    = "${var.org_name} Development 4 instance"
#   environment = var.environment
#   purpose     = var.purpose
#   subnetid    = aws_subnet.db-subnet.id
#   ec2az       = var.dev_az[1]
#   sec_group   = module.secgroup1.allow_web_sgid # aws_security_group.allow_web.id
#   eipid       = aws_eip.two.id
#   instancetype = "t3.micro"
# }

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"
  
  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "UsualKeyPairPPk"
  monitoring             = false
  vpc_security_group_ids = [module.secgroup1.allow_web_sgid]
  subnet_id              = aws_subnet.db-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three", "four", "five", "six", "seven"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "UsualKeyPairPPk"
  monitoring             = true
  vpc_security_group_ids = [module.secgroup1.allow_web_sgid]
  subnet_id              = aws_subnet.db-subnet.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "server" {
  count = 5 # create four similar EC2 instances

  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "WC Server ${count.index}"
  }
}