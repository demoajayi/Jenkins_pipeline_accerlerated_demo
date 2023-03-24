resource "aws_security_group" "Ansible_SG" {
  name        = "${var.name}-Ansible-sg"
  description = "Allow ssh"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound traffic"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Ansible_SG"
  }
}

resource "aws_security_group" "Bastion_SG" {
  name        = "${var.name}-Bastion-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "Allow ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound traffic"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Bastion_SG"
  }
}

resource "aws_security_group" "Jenkins_SG" {
  name        = "${var.name}-Jenkins-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound access"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }
  ingress {
    description      = "Allow proxy access"
    from_port        = var.proxy_port1
    to_port          = var.proxy_port1
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Jenkins_SG"
  }
}

resource "aws_security_group" "SonarQube_SG" {
  name        = "${var.name}-SonarQube_SG"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "Allow ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound access"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }
  ingress {
    description      = "Allow proxy access"
    from_port        = var.proxy_port2
    to_port          = var.proxy_port2
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-SonarQube_SG"
  }
}

resource "aws_security_group" "Docker_SG" {
  name        = "${var.name}-Docker_SG"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "Allow ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound access"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }
  ingress {
    description      = "Allow proxy access"
    from_port        = var.proxy_port1
    to_port          = var.proxy_port1
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }
  ingress {
    description      = "Allow proxy access"
    from_port        = var.proxy_port2
    to_port          = var.proxy_port2
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker_SG"
  }
}

resource "aws_security_group" "Database_SG" {
  name        = "${var.name}-Database_SG"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

   ingress {
    description      = "Allow inbound access"
    from_port        = var.MySql
    to_port          = var.MySql
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Database_SG"
  }
}

resource "aws_security_group" "ALB_SG" {
  name        = "${var.name}-ALB_SG"
  description = "Allow inbound traffic"
  vpc_id      = var.demolas_vpc

  ingress {
    description      = "Allow ssh"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

   ingress {
    description      = "Allow inbound access"
    from_port        = var.http_port
    to_port          = var.http_port
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }
  ingress {
    description      = "Allow proxy access"
    from_port        = var.proxy_port1
    to_port          = var.proxy_port1
    protocol         = "tcp"
    cidr_blocks      = [var.all_access]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_access]
  }

  tags = {
    Name = "${var.name}-ALB_SG"
  }
}