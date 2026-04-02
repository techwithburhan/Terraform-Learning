# AWS provider configure kar rahe hain (region set kar rahe hain)
provider "aws" {
  region = "eu-west-1"  # Ireland region
}

# 🔍 Latest Ubuntu AMI automatically fetch karne ke liye data source
data "aws_ami" "ubuntu" {
  most_recent = true  # latest available image pick karega

  owners = ["099720109477"] # Canonical (Ubuntu official owner ID)

  # Filter laga rahe hain specific Ubuntu version ke liye
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# 🔐 SSH access ke liye key pair create kar rahe hain
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"              # AWS me key ka naam
  public_key = file("~/.ssh/id_rsa.pub")    # local machine se public key read kar raha hai
}

# 🌐 Security Group (firewall rules define karta hai)
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"  # SG ka naam
  description = "Allow SSH and HTTP" # description

  # 🔓 Incoming traffic (SSH allow)
  ingress {
    description = "SSH access"        # rule description
    from_port   = 22                  # start port
    to_port     = 22                  # end port
    protocol    = "tcp"               # protocol
    cidr_blocks = ["0.0.0.0/0"]       # sab jagah se allow (⚠️ insecure in prod)
  }

  # 🌍 Incoming traffic (HTTP allow)
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 🔓 Outgoing traffic (sab allow)
  egress {
    from_port   = 0                   # all ports
    to_port     = 0
    protocol    = "-1"                # all protocols
    cidr_blocks = ["0.0.0.0/0"]       # anywhere
  }
}

# 🖥️ EC2 instance create kar rahe hain
resource "aws_instance" "advanced_ec2" {
  ami           = data.aws_ami.ubuntu.id  # dynamically fetched Ubuntu AMI
  instance_type = "t2.micro"              # instance type (free tier eligible)

  key_name = aws_key_pair.deployer.key_name  # SSH key attach kar rahe hain

  # Security group attach kar rahe hain
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Public IP assign karega instance ko
  associate_public_ip_address = true

  # Tags (naming & identification ke liye)
  tags = {
    Name = "Advanced-Ubuntu-EC2"
  }
}

# 🌍 Elastic IP (static public IP assign karne ke liye)
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.advanced_ec2.id  # EC2 instance se attach
  domain   = "vpc"                         # VPC based EIP
}