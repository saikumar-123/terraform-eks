
output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon"
  value       = join("", aws_eks_node_group.maagc-eks-node-group.*.id)
}

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = join("", aws_eks_node_group.maagc-eks-node-group.*.arn)
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources of the EKS Node Group"
  value       = var.enabled ? aws_eks_node_group.maagc-eks-node-group.*.resources : []
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group"
  value       = join("", aws_eks_node_group.maagc-eks-node-group.*.status)
}

###########################################################
# output values for public subnet nodegroup.
# output "eks_node_group_public_id" {
#   description = "EKS Cluster name and EKS Node Group name separated by a colon"
#   value       = join("", aws_eks_node_group.maagc-eks-node-group-public.*.id)
# }



# output "eks_node_group_public_arn" {
#   description = "Amazon Resource Name (ARN) of the EKS Node Group"
#   value       = join("", aws_eks_node_group.maagc-eks-node-group-public.*.arn)
# }



# output "eks_node_group_public_resources" {
#   description = "List of objects containing information about underlying resources of the EKS Node Group"
#   value       = var.enabled ? aws_eks_node_group.maagc-eks-node-group-public.*.resources : []
# }



# output "eks_node_group_public_status" {
#   description = "Status of the EKS Node Group"
#   value       = join("", aws_eks_node_group.maagc-eks-node-group-public.*.status)
# }



output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}

# output "kubeconfig" {
#   value = "${local.kubeconfig}"
# }
