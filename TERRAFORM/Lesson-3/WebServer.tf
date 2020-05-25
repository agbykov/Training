#-----------------------------------------------------------
# My Terraform
#
# Build Web Server diuring boot strap
#-----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_websever" {
  ami                    = "ami-076431be05aaf8080"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  key_name               = "agbykov-Frankfurt2"
  user_data              = file("./user-data.sh")
  tags = {
    Name    = "my_Amazon"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My first Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "allow_webserver"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}
