variable "lbname" {
  default = "demos-lb"
}
variable "alb_sg" {
  default = "dumms"
}
variable "lb_sn1" {
  default = "dumms"
}
variable "lb_sn2" {
  default = "dumms"
}
variable "env" {
  default = "Production"
}
variable "lbtg" {
  default = "lb-targetgroup"
}
variable "vpc_name" {
  default = "dumms"
}
variable "target_instance" {
  default = "dumms"
}