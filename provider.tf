provider "aws" {
  region = var.region
}

provider "archive" {}

terraform {
  required_version = "> 0.12.0"
}

