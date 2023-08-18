#Create Security Groups
module "secgroup1" {
  source = "./modules/secgroup"
  vpcid = aws_vpc.prod.id
}