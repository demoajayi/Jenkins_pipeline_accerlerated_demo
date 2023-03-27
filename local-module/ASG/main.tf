# Create Auto Scaling Group
resource "aws_autoscaling_group" "demos_ASG" {
name = var.asg-name
max_size = 4
min_size = 2
health_check_grace_period = 360
health_check_type  = "EC2"
desired_capacity = 3
force_delete = true
launch_configuration = aws_launch_configuration.demos_LC.id
vpc_zone_identifier  = [var.vpc_sn1, var.vpc_sn2]
target_group_arns = [var.lb_arn ]

tag{
    key = "Name"
    value = "docker_asg"
    propagate_at_launch = true
}
}

#Create Auto Scaling Group Policy
resource "aws_autoscaling_policy" "demo_asg_policy" {
name  = var.asg_policy
adjustment_type = "ChangeInCapacity"
policy_type = "TargetTrackingScaling"
autoscaling_group_name = aws_autoscaling_group.demos_ASG.id
target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }    
}

#Create AMI from Instance
resource "aws_ami_from_instance" "demos_ami" {
  name               = var.dockerprod_ami
  source_instance_id = var.ami_instance
}

#Create ASG Launch Configuration
resource "aws_launch_configuration" "demos_LC" {
  name          = var.lc_name
  image_id      = aws_ami_from_instance.demos_ami.id
  instance_type = var.lc_instance
  associate_public_ip_address = true
  security_groups = [var.asg_sg]
  key_name = var.key_pair
}
