locals {
  common_tags = {}
}

resource "aws_route53_zone" "root" {
  name = var.dns["domain_name"]

  tags = merge(local.common_tags, var.custom_tags)
}

resource "aws_route53_record" "ns_in_parent" {
  count   = length(var.subdomains)
  zone_id = aws_route53_zone.root.zone_id
  name    = var.subdomains[count.index]["domain_name"]
  type    = "NS"
  ttl     = var.subdomains[count.index]["subdomain_default_ttl"]
  records = var.subdomains[count.index]["name_servers"]
}

output "route53_root_name_servers" {
  value = aws_route53_zone.root.name_servers
}

output "route53_root_zone_id" {
  value = aws_route53_zone.root.zone_id
}
