# # count
# locals {
#   names = ["bob", "kevin", "stewart"]
#   last_names = ["jones","brown"]
# }
# resource "null_resource" "names" {
#   count = length(local.last_names)
#   triggers = {
#     name = local.last_names[count.index]
#     # last_names = local.last_names[count.index]
#   }
# }
# output "minions" {
#   value = null_resource.names
# }

# for each

# locals {
#   minions = ["bob", "kevin", "stewart"]
# }
# resource "null_resource" "minions" {
#   for_each = toset(local.minions)
#   triggers = {
#     name = each.value
#   }
# }
# output "minions" {
#   value = null_resource.minions
# }

# map for each
# locals {
#   heights = {
#     bob     = "short"
#     kevin   = "tall"
#     stewart = "medium"
#   }
# }
# resource "null_resource" "heights" {
#   for_each = local.heights
#   triggers = {
#     name   = each.key
#     height = each.value
#   }
# }
# output "heights" {
#   value = null_resource.heights
# }