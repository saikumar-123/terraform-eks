# Template to Launch EKS cluster in provate subnet assuming you had 
#VPC, Private subnets(2 AZ'S),Security groups(443), IAM role (EKSSERVICEPOLICY AND EKSCLUSTER POLICY) created outside terraform template.
resource "aws_cloudwatch_log_group" "maagc-eks-cluster-cloudwatch" {
  count             = var.enabled && length(var.enabled_cluster_log_types) > 0 ? 1 : 0
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cluster_log_retention_period
  tags = merge(
    local.common_tags,
    map(
        "Name", "${var.cluster_name}-cloudwatch"
    )
  )
}

resource "aws_eks_cluster" "maagc-eks-cluster" {
  name = var.cluster_name
  version = var.k8s-version
  role_arn = data.aws_iam_role.cluster.arn
  enabled_cluster_log_types = var.enabled_cluster_log_types
  tags = merge(
    local.common_tags,
    map(
        "Name", "${var.cluster_name}"
    )
  )


  vpc_config {
    security_group_ids      = concat(data.aws_security_groups.cluster_security_groups.ids)
    subnet_ids              = var.private_subnet_ids
    # endpoint_private_access = var.endpoint_private_access
    # endpoint_public_access  = var.endpoint_public_access
    # public_access_cidrs     = var.public_access_cidrs
  }

  depends_on = [
    aws_cloudwatch_log_group.maagc-eks-cluster-cloudwatch
  ]

}