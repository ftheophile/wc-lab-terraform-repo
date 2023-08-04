output "instance1_elastic_ip" {
  value = aws_eip.one.public_ip
}

output "instance2_elastic_ip" {
  value = aws_eip.two.public_ip
}

output "instance1_private_ip" {
  value = module.ec2server1.instance_private_ip
}

output "first_server1_state" {
  value = module.ec2server1.first_server_state
}

output "instance2_private_ip" {
  value = module.instance2.instance_private_ip
}

output "first_server2_state" {
  value = module.instance2.first_server_state
}