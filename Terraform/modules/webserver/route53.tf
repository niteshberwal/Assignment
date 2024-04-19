resource "aws_route53_zone" "private" {
 name = var.route53_zone_name
 vpc {
    vpc_id = aws_vpc.vpc.id
 }
}

resource "aws_route53_record" "lb" {
 zone_id = aws_route53_zone.private.zone_id
 name    = "www"
 type    = "A"
 alias {
    name                   = aws_lb.public.dns_name
    zone_id                = aws_lb.public.zone_id
    evaluate_target_health = false
 }
}

