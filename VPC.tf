
data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs                                = data.aws_availability_zones.available.names
  private_subnets                    = var.private_subnets
  public_subnets                     = var.public_subnets
  database_subnets                   = var.database_subnets
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  create_database_subnet_group       = var.vpc_create_database_subnets

  single_nat_gateway = var.vpc_single_nat_gateway
  enable_nat_gateway = var.vpc_enable_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags

  public_subnet_tags = {
    Type                                              = "Public"
    "Kubernetes.io/role/elb"                          = 1
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Type                                              = "Private"
    "Kubernetes.io/role/elb"                          = 1
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
  }

  database_subnet_tags = {
    Type = "DataBase"
  }

  map_public_ip_on_launch = true


}