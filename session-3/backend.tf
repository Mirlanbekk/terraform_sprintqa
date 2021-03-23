terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/session3.tfstate"
    region = "us-east-1"
  }
}
