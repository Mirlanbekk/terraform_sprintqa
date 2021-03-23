terraform {
  backend "s3" {
    bucket = "elasticbeanstalk-us-east-1-749327794284"
    key    = "tfstate/sample-module.tfstate"
    region = "us-east-1"
  }
}