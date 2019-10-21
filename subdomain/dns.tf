locals {
  common_tags = {}
}

resource "aws_route53_zone" "subdomain" {
  name = var.dns["domain_name"]

  tags = merge(local.common_tags, var.custom_tags)
}

output "route53_subdomain_name_servers" {
  value = aws_route53_zone.subdomain.name_servers
}
