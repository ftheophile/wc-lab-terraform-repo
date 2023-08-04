variable "org_name"{
    type = string
    description = "Name of organization"
}

variable "environment" {
    type =  string
    description = "Development environment"
}

variable "purpose" {
    type = string
    description = "Purpose"
    default = "Automated testing environment"
}

variable "subnetid" {
    type = string
    description = "Subnet for instance"
}

variable "ec2az" {
    type = string
    description = "Availability Zone of Instance"
}

variable "sec_group" {
    type = string
    description = "Server Security group"
}

variable "instancetype" {
    type = string
    default = "t2.micro"
    description = "Instance type"
}

variable "eipid" {
    type = string
    description = "Eip id"
}