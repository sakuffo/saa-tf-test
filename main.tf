
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.36.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count = 5
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro-${count.index + 1}"

  tags = {
    Name = "HelloWorld"
  }
}
