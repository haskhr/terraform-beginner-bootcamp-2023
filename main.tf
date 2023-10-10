terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "haskhr"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_the-nomad-pad_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum.public_path
  content_version = var.arcanum.content_version
}

resource "terratowns_home" "the-nomad-pad" {
  name = "Visit Egypt "
  description = <<DESCRIPTION
Egypt is one of the most famous touristic places such as the historical places , nice beaches and famous big cities to visit . 
DESCRIPTION
  domain_name = module.home_the-nomad-pad_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.arcanum.content_version
}

module "home_cooker-cove_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "cooker-cover" {
  name = "Do you know about Egyptian Sweets"
  description = <<DESCRIPTION
Egypt is one of the most famous countries in ME producing specilaized variarites of sweets
DESCRIPTION
  domain_name = module.home_cooker-cove_hosting.domain_name
  town = "cooker-cove"
  content_version = var.payday.content_version
}