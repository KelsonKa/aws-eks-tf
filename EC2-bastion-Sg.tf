module "public_bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-public-bastion-sg"
  description = "Security group for user-service wL publicly open"
  vpc_id      = module.vpc.vpc_id


  # Ingress rule that will allow ssh connection from any and all IPs
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]

  # Egress Rule, will allow the bastion host to reach the internet

  egress_rules = ["all-all"]
  tags         = local.common_tags


}