variable "dev-region"{
    type = string
    default = "us-east-1"
    description = "Region for deploying dev resources"
}


variable "availability_zone" {
  type = list(string)
  default = [ "us-east-1b" ]
}


variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
  description = "cidr block of my prod vpc"

}
