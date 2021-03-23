terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/session6-1.tfstate"
    region = "us-east-1"
  }
}