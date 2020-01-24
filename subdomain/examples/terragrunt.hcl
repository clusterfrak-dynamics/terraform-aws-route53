include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "github.com/clusterfrak-dynamics/terraform-aws-route53.git//subdomain?ref=v1.0.0"
}

locals {
  aws_region   = basename(dirname(get_terragrunt_dir()))
  env         = "staging"
  custom_tags = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_tags.yaml")}"))
}

inputs = {

  env = local.env

  aws = {
    "region" = local.aws_region
  }

  dns = {
    domain_name = "${local.env}.domain.name"
  }

  custom_tags = merge(
    {
      Env = local.env
    },
    local.custom_tags
  )

  records = {
    "myrecord" = {
      name = "test"
      type = "A"
      ttl  = 300
      records = [
        "8.8.8.8"
      ]
    }
  }
}
