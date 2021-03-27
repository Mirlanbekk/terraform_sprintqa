  
terraform {
  backend "s3" {
    bucket = "terraformback0101"
    key    = "tfstate/session9.tfstate"
    region = "us-east-1"
  }
}