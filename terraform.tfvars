region = "us-east-2"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

tags = {
  Owner-Email = "taiwolawal360@gmail.com"
  Managed-By  = "Terraform"
}

environment = "DEV"

ami = "ami-0fb653ca2d3203ac1"

keypair = "EC2 Tutorial"

account_no = 918670967067

master-username = "taiwo"

master-password = "password"