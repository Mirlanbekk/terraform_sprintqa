# provider "aws" {
#     region = "us-east-1"
# }
# resource "aws_instance" "web" {
#   for_each = {
#       dev = "t2.micro",
#       prod = "t2.large"
#   }
#   ami                    = "ami-038f1ca1bd58a5790"
#   instance_type          = each.value
#   tags = {
#     # Name = "My_web ${count.index}"
#       Name = "My_web ${each.key}"
#   }
# }

# output "instance_ip" {

#     # value = aws_instance.web[*].public_ip
#     value = [for instance in aws_instance.web: instance.public_ip]

# }