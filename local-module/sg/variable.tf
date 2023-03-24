variable "name" {
    description = "name to assocaited to the resources"
  default = "Demolas"
}
variable "demolas_vpc" {
  default = "dummy"
}
variable "ssh_port" {
  default = 22
}
variable "http_port" {
  default = 80
}
variable "proxy_port1" {
  default = 8080
}
variable "proxy_port2" {
  default = 9000
}
variable "MySql" {
  default = 3306
}
variable "all_access" {
  default = "0.0.0.0/0"
}