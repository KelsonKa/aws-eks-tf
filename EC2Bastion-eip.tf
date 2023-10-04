resource "aws_eip" "bastion_eip" {
  instance = module.ec2_bastion_public.id
  vpc      = true
  depends_on = [
    module.ec2_bastion_public,
    module.vpc
  ]
  tags = local.common_tags
}