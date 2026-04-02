provider "aws" {
  region = "eu-west-1"  # Ireland
}

resource "aws_instance" "basic_ec2" {
  ami           = "ami-0fc5d935ebf8bc3bc"  # Ubuntu 22.04 LTS (eu-west-1)
  instance_type = "t2.micro"

  tags = {
    Name = "Ubuntu-EC2"
  }
}