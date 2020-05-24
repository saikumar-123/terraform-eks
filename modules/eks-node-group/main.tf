  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

resource "aws_eks_node_group" "maagc-eks-node-group" {
  count           = var.enabled ? 1 : 0
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = data.aws_iam_role.nodegroup.arn
  subnet_ids      = var.public_subnet_ids
#   ami_type        = data.aws_ami.maagc_eks_worker_ami
  ami_type        = var.ami_type
  instance_types  = var.maagc_node_instance_type
  disk_size       = var.root_block_size
  labels          = var.kubernetes_labels
  tags            = local.tags
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }
  dynamic "remote_access" {
    for_each = var.ec2_key_name != null && var.ec2_key_name != "" ? ["true"] : []
    content {
      ec2_ssh_key               = var.ec2_key_name
      source_security_group_ids  = concat(data.aws_security_groups.nodegroup_security_groups.ids)
    }
  }
  depends_on = [
    var.module_depends_on
  ]

}

# resource "aws_eks_node_group" "maagc-eks-node-group-public" {
#   count           = var.enabled ? 1 : 0
#   cluster_name    = var.cluster_name
#   node_group_name = "${var.cluster_name}-node-group-public"
#   node_role_arn   = data.aws_iam_role.nodegroup.arn
#   subnet_ids      = var.public_subnet_ids
# #   ami_type        = data.aws_ami.maagc_eks_worker_ami
#   ami_type        = var.ami_type
#   instance_types  = var.maagc_node_instance_type
#   disk_size       = var.root_block_size
#   labels          = var.kubernetes_labels
#   tags            = local.tags
#   scaling_config {
#     desired_size = var.desired_capacity
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }
#   dynamic "remote_access" {
#     for_each = var.ec2_key_name != null && var.ec2_key_name != "" ? ["true"] : []
#     content {
#       ec2_ssh_key               = var.ec2_key_name
#       source_security_group_ids  = concat(data.aws_security_groups.nodegroup_security_groups.ids)
#     }
#   }
#   depends_on = [
#     var.module_depends_on
#   ]

# }






