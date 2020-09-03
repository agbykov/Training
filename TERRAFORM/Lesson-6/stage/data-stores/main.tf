provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-lesson-6-state"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lesson-6-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-lesson-6"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "example_database"
  username          = "admin"
  password          = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "mysql-master-password-stage"
}
