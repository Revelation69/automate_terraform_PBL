terraform {
  backend "s3" {
    bucket         = "mike-pbl18"
    key            = "global/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

terraform {
  backend "remote" {
    organization = "Revon"

    workspaces {
      name = "automate_terraform_PBL"
    }
  }
}