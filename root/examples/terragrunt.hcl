include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "github.com/clusterfrak-dynamics/terraform-aws-route53.git//root?ref=v1.0.0"
}

locals {
  aws_region  = "eu-west-1"
  env         = "root"
  custom_tags = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_tags.yaml")}"))
}

inputs = {

  env = local.env

  aws = {
    "region" = local.aws_region
  }

  dns = {
    domain_name = "domain.name"
  }

  subdomains = [
    {
      domain_name           = "development.domain.name",
      subdomain_default_ttl = 300
      name_servers = [
        "ns-1113.awsdns-11.org",
        "ns-1716.awsdns-22.co.uk",
        "ns-556.awsdns-05.net",
        "ns-94.awsdns-11.com",
      ]
    },
    {
      domain_name           = "staging.domain.name",
      subdomain_default_ttl = 300
      name_servers = [
        "ns-1400.awsdns-47.org",
        "ns-1973.awsdns-54.co.uk",
        "ns-371.awsdns-46.com",
        "ns-755.awsdns-30.net",
      ]
    },
  ]

  custom_tags = merge(
    {
      Env = local.env
    },
    local.custom_tags
  )
}
