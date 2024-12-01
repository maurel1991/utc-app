terraform {
  backend "s3" {
    bucket = "week6-od-bucket-terraform"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "statefile-lock"
    encrypt = true
  }
}