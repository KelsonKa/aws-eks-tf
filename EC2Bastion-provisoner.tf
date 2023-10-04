resource "null_resource" "copy-ec2-keys" {
  depends_on = [module.ec2_bastion_public]
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("Key-Pair/Terraform-Keys.pem")
  }
  provisioner "file" {
    source      = "Key-Pair/Terraform-Keys.pem"
    destination = "/tmp/Terraform-Keys.pem"
  }

  provisioner "remote-exec" {
    inline = [
      " sudo chmod 400 /tmp/Terraform-Keys.pem"
    ]
  }

  provisioner "local-exec" {
    command     = "echo VPC created on 9/6/2023 and VPC ID ${module.vpc.vpc_id} >> vpc-id.txt"
    working_dir = "Key-Pair"
  }
}