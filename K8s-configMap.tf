data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

#Locals Block help us define our aws auth CM while using terraform to make it dynamic
# Will write in annotation for both configmap roles and users
locals {
  configmap_roles = [
    {
        rolearn = "${aws_iam_role.eks_nodegroup_role.arn}"
        usernmae = "system:node:{{EC2PrivateDNSName}}"
        groups = ["system:bootstrappers", "system:nodes"]
    },
   
  ]
  configmap_users = [

    {
        userarrn = "${aws_iam_user.admin_user.arn}"
        username = "${aws_iam_user.admin_user.name}"
        groups = ["system:masters"]
    },

    {
        userarrn = "${aws_iam_user.basic_user.arn}"
        username = "${aws_iam_user.basic_user.name}"
        groups = ["system:masters"]
    },

  ]
}

resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [aws_eks_cluster.eks-Cluster]  
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.configmap_roles)
    mapUsers = yamlencode(local.configmap_users)
  }
}