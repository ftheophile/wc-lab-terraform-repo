resource "aws_instance" "my-first-server" {
  ami               = "ami-053b0d53c279acc90"
  instance_type     = var.instancetype
  subnet_id         = var.subnetid
  availability_zone = var.ec2az
  vpc_security_group_ids   = [var.sec_group]

  user_data = <<-EOF
#!/bin/sh
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo -i
echo 'wirfon first server' > /var/www/html/index.html
EOF

  tags = {
    Name = var.org_name
    Env = "${var.environment}-environment"
    Purpose = "${var.purpose}"
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my-first-server.id
  allocation_id = var.eipid
}