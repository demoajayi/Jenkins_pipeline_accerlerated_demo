output "lbtg" {
    value = aws_lb_target_group.demoslb-TG.arn
}

output "lb_DNS" {
    value = aws_lb.demoslb.dns_name
}

output "lb_zone_id" {
    value = aws_lb.demoslb.zone_id
}

output "lb_arn" {
    value = aws_lb.demoslb.arn
}