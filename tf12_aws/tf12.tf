terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_read" {
  bucket = "my-tf-log-bucket"
  acl    = "public-read"
  tags = {
    yor_trace = "6a5e4453-9d64-4a92-94d5-7395d8b45e98"
  }
}
resource "aws_s3_bucket" "public_read_write" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  tags = {
    yor_trace = "3131c9b6-e1e6-4b67-b67a-5519d49a385c"
  }
}

resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.foo_vpc.id
  ingress {
    description = "TCP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 69
    to_port   = 69
    protocol  = "udp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = {
    yor_trace = "30e6ef74-dd7a-4b86-8203-bc4479798c9c"
  }
}