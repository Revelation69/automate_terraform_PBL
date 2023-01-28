region = "us-east-2"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "dev"

ami-web = "ami-055760ada4ad8604d"

ami-bastion = "ami-04982c1eb0d8f690d"

ami-nginx = "ami-001194a78b6ad19cb"

ami-sonar = "ami-046082dc8d129d785"

keypair = "devops"

account_no = "839942615319"

master-password = "michaeloajala"

master-username = "michael"


tags = {
  Owner-Email = "mickelmicho6991@gmail.com"
  Managed-By  = "Terraform"
}