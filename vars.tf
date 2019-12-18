variable  "instance_count"  {
  default = "1"
}
variable "instance_tags"  {
  type  = "list"
  default = [ "devops_tomcat_dev"]
}
