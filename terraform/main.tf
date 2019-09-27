terraform { 
  backend "s3" {
  } 
}

provider "aws" { 
  region  = "us-west-2" 
  profile = lookup(var.env_tags, "environment", "development")
}

locals {
  tags = merge(var.tags, var.env_tags)
}
