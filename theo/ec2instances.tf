
module "ec2server1" {
  source      = "./modules/ec2server"
  org_name    = "${var.org_name} Production instance"
  environment = var.environment
  purpose     = var.purpose
  subnetid    = aws_subnet.app-subnet.id
  ec2az       = var.dev_az[0]
  sec_group   = module.secgroup1.allow_web_sgid #aws_security_group.allow_web.id
  eipid       = aws_eip.one.id
}

module "instance2" {
  source      = "./modules/ec2server"
  org_name    = "${var.org_name} Development instance"
  environment = var.environment
  purpose     = var.purpose
  subnetid    = aws_subnet.db-subnet.id
  ec2az       = var.dev_az[1]
  sec_group   = module.secgroup1.allow_web_sgid # aws_security_group.allow_web.id
  eipid       = aws_eip.two.id
  instancetype = "t3.micro"
}