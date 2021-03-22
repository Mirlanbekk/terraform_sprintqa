terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/data-source.tfstate"
    region = "us-east-1"
  }
}


