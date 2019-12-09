provider "aws" {
  region  = "ap-south-1"
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
  ami  = "ami-0123b531fc646552f"
  instance_type = "t2.medium"
#  associate_public_ip_address = "true"
  count = "${var.instance_count}"
  key_name  = "devops"
  vpc_security_group_ids  = ["${aws_security_group.my-sg.id}"]

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

resource "aws_instance" "test" {
  ami  = "ami-0123b531fc646552f"
  instance_type = "t2.medium"
 # associate_public_ip_address = "true"
  count = "${var.instance_count}"
  key_name  = "devops"
  vpc_security_group_ids  = ["${aws_security_group.my-sg.id}"]

tags  = {
 #Name  = "PROD"
#  Name = "${format("example-%03d", count.index + 1)}"
 Name  = "${element(var.instance_tags, count.index)}"
#  Name  = "{count.index}"
}
lifecycle {
  create_before_destroy = "false"
}
}

resource "aws_eip_association" "eip" {
  instance_id = "${aws_instance.example[count.index]}"
  allocation_id = "eipalloc-00496129794133ccb"
}

resource "aws_eip_association" "eip2" {
  instance_id = "${aws_instance.test[count.index]}"
  allocation_id = "eipalloc-0c86323a2fde68dfb"
}
