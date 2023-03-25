variable "vpc_name" {
  default = "Demolas_vpc"
}

variable "name" {
  default = "Demolas"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az1" {
  default = "eu-west-2a"
}

variable "az2" {
  default = "eu-west-2b"
}

variable "Priv_subnet1" {
  default = "10.0.1.0/24"
}

variable "Priv_subnet2" {
  default = "10.0.2.0/24"
}

variable "Pub_subnet1" {
  default = "10.0.3.0/24"
}

variable "Pub_subnet2" {
  default = "10.0.4.0/24"
}
variable "key-name" {
  default = "projects"
}
variable "ami" {
  default = "ami-05c96317a6278cfaa"
}
# variable "amii" {
#   default = "ami-0aaa5410833273cfe"
# }
variable "inst_type" {
  default = "t3.medium"
}
variable "docker_name" {
  default = "docker_server"
}

# variable "ami-name" {
# default = "host_ami"
# }
# variable "target-instance" {
# default = "docker_server"
# }
# variable "launch-configname" {
# default = "host_ASG_LC"
# }

# variable "sg_name3" {
# default = "                                                "
# }

# variable "asg-group-name" {
# default = "demos_ASG"
# }
# variable "vpc-zone-identifier" {
# default = ""
# }
# variable "target-group-arn" {
# default = ""
# }
# variable "asg-policy" {
# default = ""
# }