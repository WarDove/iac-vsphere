terraform {
  required_version = ">=1.2.6"
  backend "s3" {
    region = "eu-central-1"
    profile = "terraform"
    key = "terraform.tfstate"
    bucket = "azin-infra-dev-state"
  }
}
