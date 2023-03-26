#Create Load Balancer
resource "aws_lb" "demoslb" {
  name               = var.lbname
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = [var.lb_sn1, var.lb_sn2]
  enable_deletion_protection = true 
  tags = {
    Environment = var.env
  }
}
#Create LB Target Group                                    
resource "aws_lb_target_group" "demoslb-TG" {
  name     = var.lbtg
  target_type = "instance"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_name
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 4
    interval = 45
  }
}
# Create LB Listener
resource "aws_lb_listener" "demos_lb_listener" {
  load_balancer_arn = aws_lb.demoslb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demoslb-TG.arn
  }
}

#Create LB Target Group Attachment
resource "aws_lb_target_group_attachment" "demos_lbtg_attcmt" {
  target_group_arn = aws_lb_target_group.demoslb-TG.arn
  target_id        = var.target_instance
  port             = 8080
}