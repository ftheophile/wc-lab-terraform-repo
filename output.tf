output "instance_elastic_ip" {
  value = aws_eip.one.public_ip
}

output "instance_private_ip" {
  value = aws_instance.my-first-server.private_ip
}

output "first_server_state" {
  value = aws_instance.my-first-server.instance_state
}