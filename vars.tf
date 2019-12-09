variable  "instance_count"  {
  default = "2"
}
variable "instance_tags"  {
  type  = "list"
  default = [ "DEV", "PROD"]
}
