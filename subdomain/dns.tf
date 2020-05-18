locals {
  common_tags = {}
}

resource "aws_route53_zone" "subdomain" {
  name = var.dns["domain_name"]

  tags = merge(local.common_tags, var.custom_tags)
}

data "aws_route53_zone" "selected" {
  zone_id     = aws_route53_zone.subdomain.zone_id
}

output "route53_name_servers" {
  value = aws_route53_zone.subdomain.name_servers
}

output "route53_hosted_zone_id" {
  value = aws_route53_zone.subdomain.zone_id
}

output "route53_name" {
  value = data.aws_route53_zone.selected.name
}
