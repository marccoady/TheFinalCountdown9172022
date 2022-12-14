# ---- netsec/main.tf


resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "fc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "fc_vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "fc_pb_sn" {
  count                   = length(var.pb_cidrs)
  vpc_id                  = aws_vpc.fc_vpc.id
  cidr_block              = var.pb_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = ["us-east-1a", "us-east-1b"][count.index]

  tags = {
    Name = "fc-pb_${count.index + 1}"
  }
}
resource "aws_security_group" "fc_pb_sg" {
  name        = "final_cd_sg"
  description = "SSH inbound traffic"
  vpc_id      = aws_vpc.fc_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ext_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
