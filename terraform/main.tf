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

resource "aws_eks_cluster" "wordpress_eks" { 
  name      = "wordpress-eks"
  role_arn  = var.eks_iam_role

  vpc_config { 
    subnet_ids = var.eks_aws_subnets
  } 
}

output "endpoint" { 
  value = aws_eks_cluster.wordpress_eks.endpoint
}

output "kubeconfig-certificate-authority-data" { 
  value = aws_eks_cluster.wordpress_eks.certificate_authority.0.data
}
