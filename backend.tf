# terraform {
#   backend "s3" {
#     bucket         = "pbl18"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

terraform {
  backend "remote" {
    organization = "learn-terraform-now"

    workspaces {
      name = "automate_terraform_PBL"
    }
  }
}