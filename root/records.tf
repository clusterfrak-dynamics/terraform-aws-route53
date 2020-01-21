resource "aws_route53_record" "records" {
  for_each = var.records
  zone_id  = aws_route53_zone.root.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = each.value.records
}
