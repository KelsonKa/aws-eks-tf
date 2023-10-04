/*resource "aws_eks_node_group" "Public-NG" {
  cluster_name    = aws_eks_cluster.eks-Cluster.name
  node_group_name = "${local.name}-Public-NG"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.vpc.public_subnets
  version         = var.cluster_version

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t2.micro"]
  remote_access {
    ec2_ssh_key = "Terraform-Keys"
  }



  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }


  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
    kubernetes_config_map_v1.aws-auth
  ]

  tags = {
    name = "Public-Node"
  }
}
*/