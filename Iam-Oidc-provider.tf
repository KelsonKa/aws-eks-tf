data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
  thumbprint_list = [var.eks_oidc_root_ca_thumbprint]
  url = aws_eks_cluster.eks-Cluster.identity[0].oidc[0].issuer

  tags = merge( {
    Name = "${var.cluster_name}-eks-irsa"
  },
  local.common_tags
  )
}

output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.eks_oidc_provider.arn
  description = "AWS IAM Open ID Connect Provider ARN"
}

locals { #Extract OIDc from oidc provider arn
  aws_iam_openid_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.eks_oidc_provider.arn}"), 1)
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  description = "AWS IAM Open ID Connect Provider extract from ARN"  
  value = local.aws_iam_openid_connect_provider_extract_from_arn

}