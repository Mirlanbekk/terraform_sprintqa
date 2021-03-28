# provider "aws" {
#    region = "us-east-1"
# }
# resource "aws_vpc" "my_vpc" {

#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "my_vpc"
#   }

# }

# variable "private_cidr_mask" {
#   default = {
#     "us-east-1a" = "10.0.1.0/24"
#     "us-east-1b" = "10.0.2.0/24"
#   }
# }

# variable "public_cidr_mask" {
#   default = {
#     "us-east-1c" = "10.0.3.0/24"
#     "us-east-1d" = "10.0.4.0/24"
#     "us-east-1e" = "10.0.5.0/24"
#   }
# }

# resource "aws_subnet" "private_subnet" {

#   for_each = var.private_cidr_mask

#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   availability_zone = each.key
#   map_public_ip_on_launch = false

#   tags = {
#     "Name" = "${each.key}-private_subnet"
#   }

# }


# resource "aws_subnet" "public_subnet" {

#   for_each = var.public_cidr_mask

#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   availability_zone = each.key
#   map_public_ip_on_launch = true

#   tags = {
#     "Name" = "${each.key}-public_subnet"
#   }

# }