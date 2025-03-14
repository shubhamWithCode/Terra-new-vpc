terraform {
  backend "s3" {
    bucket = "nike-tfstate-main"
    key = "nikevpctf/terraform.tfstate"
    region = "us-east-1"
  }
}