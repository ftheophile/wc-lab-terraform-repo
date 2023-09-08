# resource "aws_eip" "one" {
#   domain = "vpc"
#   # network_interface = aws_network_interface.nic.id
#   depends_on = [aws_internet_gateway.gw]
# }

# resource "aws_eip" "two" {
#   domain = "vpc"
#   # network_interface = aws_network_interface.nic.id
#   depends_on = [aws_internet_gateway.gw]
# }

resource "aws_eip" "eips" {
  domain = "vpc"
  for_each = toset(["one", "two", "three", "four", "five"])
  # network_interface = aws_network_interface.nic.id
  depends_on = [aws_internet_gateway.gw]
}