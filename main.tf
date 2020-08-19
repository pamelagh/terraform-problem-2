provider "aws" {
  profile = var.profile
  region  = var.region
}

module "static_site" {
  source = "./modules/static_site"
  domain_name = var.domain_name
}
