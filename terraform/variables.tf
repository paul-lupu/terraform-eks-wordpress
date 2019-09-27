variable "env_tags" { 
  description = "Environment tags"
  type        = "map" 
}

variable "tags" { 
  description = "Local tags"
  type        = "map" 
}

variable "eks_aws_subnets" { 
  description = "Subnets for aws eks cluster"
  type        = "list"
}

variable "eks_iam_role" { 
  description = "Iam role for eks cluster" 
}
