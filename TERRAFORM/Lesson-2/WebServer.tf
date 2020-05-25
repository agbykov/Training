#-----------------------------------------------------------
# My Terraform
#
# Build Web Server diuring boot strap
#-----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_websever" {
  ami                    = "ami-0a9e2b8a093c02922"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'
echo "<h2>WebServer with IP : $myip</h2><br>Build by Terraform" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
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
    cidr_blocks = ["212.103.50.156/32"]
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
