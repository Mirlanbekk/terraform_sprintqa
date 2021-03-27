terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/wordpress.tfstate"
    region = "us-east-1"
  }
}