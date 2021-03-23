resource "aws_s3_bucket" "b" {
  bucket = "terraformbackmirlan"
  acl    = "private"
  force_destroy = true
  tags = {
    Name = "terraformbackmirlan"
  }
}