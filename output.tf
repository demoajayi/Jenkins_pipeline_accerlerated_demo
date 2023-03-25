output "vpc_id" {
  value = module.vpc.vpc_id
}
output "Bastion-ip" {
  value = module.Bastion.public_ip
}

output "Ansible-ip" {
  value = module.Ansible.private_ip
}

output "Docker-ip" {
  value = module.Docker.*.private_ip
}

output "Jenkins-ip" {
  value = module.Jenkins.private_ip
}

output "SonarQube-ip" {
  value = module.SonarQube.public_ip
}
# output "prod_elb_dns" {
#   value = module.Prod_elb.prod_elb_dns
# }
output "jenkins_elb_dns" {
  value = module.jenkins_elb.jenkins_elb_dns
}
# output "LB_DNS" {
#   value = module.Application_loadBalancer.lb_DNS
# }
