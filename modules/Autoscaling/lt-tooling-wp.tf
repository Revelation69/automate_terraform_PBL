# Launch template for wordpress

resource "aws_launch_template" "wordpress-launch-template" {
  name                   = var.wordpress-launch-name
  instance_type          = var.instance_type
  image_id               = var.ami-web
  vpc_security_group_ids = var.web-sg

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = var.resource_type


    tags = {
      Name = var.wordpress-launch-name
    }
  }

  user_data = filebase64("${path.module}/wordpress.sh")
}

# launch template for tooling
resource "aws_launch_template" "tooling-launch-template" {
  name                   = var.tooling-launch-name
  instance_type          = var.instance_type
  image_id               = var.ami-web
  vpc_security_group_ids = var.web-sg

  iam_instance_profile {
    name = var.instance_profile
  }

  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = var.resource_type


    tags = {
      Name = var.tooling-launch-name
    }
  }

  user_data = filebase64("${path.module}/tooling.sh")
}
