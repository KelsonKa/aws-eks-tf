resource "aws_iam_user" "admin_user" {
    name = "${local.name}-Techsecom-admin"
    path = "/"
    tags = local.common_tags
    force_destroy = true
}



resource "aws_iam_user_policy_attachment" "admin_user_attach" {
  user = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
