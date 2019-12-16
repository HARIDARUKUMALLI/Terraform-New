output "instance_ips" {
  value = ["${aws_instance.example.*.public_ip}"]
}
output "security_group_id" {
value  = "${aws_security_group.cicd-sg.id}"
}
