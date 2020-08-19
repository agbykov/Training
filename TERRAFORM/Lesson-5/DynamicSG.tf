#-----------------------------------------------------------
# My Terraform
#
# Build Dynamic SG
#-----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_security_group" "my_webserver" {
  name        = "Dynamic Web Server SG"
  description = "Dynamic Web Server Security Group Open 22/80/443 ports"

  dynamic "ingress" {
    for_each ["80", "443", "22"]
  content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]      
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Dynamic SG allow_webserver HTTP(S) and SSH"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}
