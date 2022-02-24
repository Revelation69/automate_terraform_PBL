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

ami-web = "ami-09df241cd2eec65b9"

ami-bastion = "ami-041dda9ba00726fa3"

ami-nginx = "ami-0fd5733bb5c207b57"

ami-sonar = "ami-08bf4f16a51d3afaf"

keypair = "EC2 Tutorial"

account_no = 918670967067

master-username = "taiwo"

master-password = "password"