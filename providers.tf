terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "kelson-aws"
    key    = "techsecom/AWS-EKS.tfstate"
    region = "us-east-1"

    dynamodb_table = "techsecom-aws-eks"
  }


}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}



data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks-Cluster.id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = aws_eks_cluster.eks-Cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-Cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token 
}

provider "github" {
  token = var.github_token
}







