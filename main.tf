provider "aws" {
  region  = "ap-south-1"
}
resource "aws_security_group" "cicd-sg" {
  name  = "CD-sg"
  vpc_id  = "vpc-8b698fe2"
  ingress {
  from_port = 22
  to_port = 22
  protocol  = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port = 8080
  to_port = 8080
  protocol  = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh-sg"
  }
}



resource "aws_instance" "example" {
  ami  = "ami-0123b531fc646552f"
  instance_type = "t2.medium"
  associate_public_ip_address = "true"
  count = "${var.instance_count}"
  key_name  = "realtime"
  vpc_security_group_ids  = ["${aws_security_group.cicd-sg.id}"]

tags  = {
 #Name  = "DEV"
# Name = "${format("example-%03d", count.index + 1)}"
 Name  = "${element(var.instance_tags, count.index)}"
#  Name  = "{count.index}"
}
lifecycle {
  create_before_destroy = "false"
}
}

