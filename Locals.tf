locals {
  Owners      = var.Business_Divison
  Environment = "${var.env}- Personal-VPC"
  name        = "${var.Business_Divison}-${var.env}"

  common_tags = {
    owners      = local.name
    Environment = local.Environment
  }
  eks_cluster_name = "${local.name}-${var.cluster_name}"
}
