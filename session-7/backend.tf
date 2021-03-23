terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/vpc-sample.tfstate"
    region = "us-east-1"
  }
}
