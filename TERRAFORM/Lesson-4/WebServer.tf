#-----------------------------------------------------------
# My Terraform
#
# Build Web Server during boot strap
#-----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_websever" {
  ami                    = "ami-076431be05aaf8080" # Amazon Linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  key_name               = "agbykov-Frankfurt2"
  user_data              = templatefile("user-data.sh.tpl", {f_name = "Alexis", l_name = "Bykov", names = ["Vasya", "Kolya", "Petya", "John", "Donald", "Paulina"] })
  tags = {
    Name    = "Amazon AMI based Apache Web Server"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "Standard Web Server Security Group"
  description = "Standard Web Server Security Group Open 22/80/443 ports"

  ingress {
    from_port   = 80 #http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 #https
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22 #ssh
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
    Name    = "allow_webserver HTTP(S) and SSH"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}
