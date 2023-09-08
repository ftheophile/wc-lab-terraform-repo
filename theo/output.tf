output "instance1_elastic_ip" {
  value = aws_eip.eips["one"].public_ip
}

output "instance2_elastic_ip" {
  value = aws_eip.eips["two"].public_ip
}

output "instance1_private_ip" {
  value = module.ec2server1["one"].instance_private_ip
}

output "first_server1_state" {
  value = module.ec2server1["one"].first_server_state
}

output "instance2_private_ip" {
  value = module.ec2server1["two"].instance_private_ip
}

output "first_server2_state" {
  value = module.ec2server1["two"].first_server_state
}