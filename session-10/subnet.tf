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

# # # 
# variable "cidr_block_public" {

#   default = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  
# }

# variable "cidr_block_private" {

#   default = ["10.0.9.0/24", "10.0.10.0/24"]
  
# }

# # # 3 public subnet with this cidr_block_public using for_each 
# # # 2 private subnet with this cidr_block_private using for_each 

# resource "aws_subnet" "public_subnet" {
# #   for_each = toset(var.cidr_block_public)
#   for_each = {for index, cidr in var.cidr_block_public : index => cidr}
#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   map_public_ip_on_launch = true
# }

# resource "aws_subnet" "private_subnet" {
#   # for_each = toset(var.cidr_block_private)
#   for_each = {for index, cidr in var.cidr_block_private : index => cidr}
#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   map_public_ip_on_launch = false
# }

# output "cidr_private" {

#   value = {for index, cidr in var.cidr_block_private : index => cidr}
  
# }