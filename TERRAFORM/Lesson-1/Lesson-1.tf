provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_Ubuntu" {
  count         = 1
  ami           = "ami-0e342d72b12109f91"
  instance_type = "t2.micro"
  tags = {
    Name    = "my_Ubuntu"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "my_Amazon" {
  ami           = "ami-0a9e2b8a093c02922"
  instance_type = "t2.micro"
  tags = {
    Name    = "my_Amazon"
    Owner   = "Alexis Bykov"
    Project = "Terraform Lessons"
  }
}
