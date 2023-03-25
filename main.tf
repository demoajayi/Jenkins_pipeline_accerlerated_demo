module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = var.vpc_name
  cidr                   = var.vpc_cidr
  azs                    = [var.az1, var.az2]
  private_subnets        = [var.Priv_subnet1, var.Priv_subnet2]
  public_subnets         = [var.Pub_subnet1, var.Pub_subnet2]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.name}-VPC"
  }
}
module "sg" {
  source      = "./local-module/sg"
  demolas_vpc = module.vpc.vpc_id
}
module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = var.key-name
  public_key = file("~/keypairs/projects.pub")
}
module "Ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${var.name}-Ansible"
  ami                    = var.ami
  instance_type          = var.inst_type
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.ansible-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data = templatefile("./User_data/ansible.sh",
  {
      STAGEcontainer = "./playbooks/STAGEcontainer.yml",
      PRODcontainer = "./playbooks/PRODcontainer.yml",
      STAGE_Server_priv_ip = module.Docker[0].private_ip,
      PROD_Server_priv_ip = module.Docker[1].private_ip,
      keypair = "~/keypairs/projects"  
    }
  )
  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.name}-Ansible"
  }
}

module "Docker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.name}-Docker"
  ami                    = var.ami
  instance_type          = var.inst_type
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.docker-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  count                  = 2
  user_data              = file("./User_data/docker.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.docker_name}${count.index}"
  }
}

module "SonarQube" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "SonarQube"
  ami                    = var.ami
  instance_type          = var.inst_type
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.sonarqube-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./User_data/sonar.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.name}-SonarQube"
  }
}

module "Jenkins" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.name}-Jenkins"
  ami                    = var.ami
  instance_type          = var.inst_type
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.jenkins-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data              = templatefile("./User_data/jenkins.sh",

   {
      keypair = "~/keypairs/projects"
    }
  )

  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.name}-Jenkins"
  }
}

module "Bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.name}-Bastion"
  ami                    = var.ami
  instance_type          = var.inst_type
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.bastion-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = templatefile("./User_data/bastion.sh",
    {
      keypair = "~/keypairs/projects"
    }
  )
  tags = {
    Terraform   = "true"
    Environment = "dev"
    name        = "${var.name}-Bastion"
  }
}

module "jenkins_elb" {
  source      = "./local-module/jenkins-elb"
  subnet_id1  = module.vpc.public_subnets[0]
  subnet_id2  = module.vpc.public_subnets[1]
  security_id = module.sg.alb-sg-id
  jenkins_id  = module.Jenkins.id
}
# module "Application_loadBalancer" {
#   source = "./local-module/ALB"
#   alb_sg   = module.sg.alb-sg-id
#   lb_sn1 = module.vpc.public_subnets[0]
#   lb_sn2 = module.vpc.public_subnets[1]
#   vpc_name = module.vpc.vpc_id
#   target_instance = module.Docker[1].id
# }
# module "Auto_Scaling_Group" {
#  source = "./local-module/ASG"
#  vpc_sn1 = module.vpc.public_subnets[0]
#  vpc_sn2 = module.vpc.public_subnets[1]
#  lb_arn = module.Application_loadBalancer.lb_arn
#  asg_sg = module.sg.docker-sg-id
#  key_pair = module.key_pair.key_pair_name
#  ami_instance = module.Docker[1].id

# }

# module "Prod_elb" {
#   source      = "./local-module/Prod_elb"
#   subnet_id1  = module.vpc.public_subnets[0]
#   subnet_id2  = module.vpc.public_subnets[1]
#   security_id = module.sg.alb-sg-id
#   Prod_id     = module.Docker[1].id
# }