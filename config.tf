provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/mbottini/.aws/credentials"
  profile = "softtek"

}

terraform {
  backend "s3" {
    bucket = "terraform-states-syseng"
    key = "mapb1/p1/terraform.tfstate"
    region = "us-west-1"
    profile = "softtek"
  }
}
