variable "dev-region" {
    type = string
    default = "us-east-1"
    description = "Region to deployment development resources" 
}

variable "prod-region" {
    type = list(string)
    default = ["us-east-1"]
    description = "Region to deployment Production resources" 
}

variable "dev_tags" {
    type = number
    default = 1234.45
}

variable "org_name" {
    type = string

}

variable "environment" {
    type = string
}

variable "purpose" {
    type = string
    default = "Cloud learning"
}