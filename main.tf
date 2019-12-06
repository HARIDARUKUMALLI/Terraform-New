provider "aws" {
  region  = "us-east-1"
}
resource "aws_security_group" "my-sg" {
  name  = "Test-sg"
  vpc_id  = "vpc-8b698fe2"
  ingress {
  from_port = 22
  to_port = 22
  protocol  = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh-sg"
  }
}



resource "aws_instance" "example" {
  ami  = "ami-04b9e92b5572fa0d1"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  count = "${var.instance_count}"
  key_name  = "MyTest"
  vpc_security_group_ids  = ["${aws_security_group.my-sg.id}"]

tags  = {
#  Name  = "example"
#  Name = "${format("example-%03d", count.index + 1)}"
  Name  = "${element(var.instance_tags, count.index)}"
#  Name  = "{count.index}"
}
lifecycle {
  create_before_destroy = "false"
}
}
