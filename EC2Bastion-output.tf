output "bstion-pip" {
  value = aws_eip.bastion_eip.public_ip
}

output "bastion-instance-id" {
  value = module.ec2_bastion_public.id
}

output "bastion-host-arn" {
  value = module.ec2_bastion_public.arn
}

output "bastion-host-ami" {
  value = module.ec2_bastion_public.ami
}