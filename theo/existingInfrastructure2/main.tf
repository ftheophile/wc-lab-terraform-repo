provider "aws" {
    region = "us-east-1"
    profile = "default"
}

# terraform plan -generate-config-out=generated_config.tf
# import {
#     id = "i-02b4369dcd7bc13f3"
#     to = aws_instance.testinstance2
# }