#Route 53 
resource "aws_route53_zone" "demos_R53" {
  name = var.domain_name 
  force_destroy = true
} 

#Record
resource "aws_route53_record" "demos-ns" {
  zone_id = aws_route53_zone.demos_R53.zone_id
  name    = var.domain_name
  type    = var.record_type

  alias {
    name                   = var.lb_dns
    zone_id                = var.lb_zoneid
    evaluate_target_health = true
  }
}
