resource "aws_eks_cluster" "eks-Cluster" {
  name     = "${local.name}-Techsecom-cluster"
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.cluster_version


  # States where the EKS cluster should be launched, putting it in public subnet allows EKS controlplane to easily communicate
  vpc_config {
    subnet_ids              = module.vpc.public_subnets
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  # Gives EKS Cluster an ipvd cidr range
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]
}