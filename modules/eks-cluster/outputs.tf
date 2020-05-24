# Output file for Cluster properties.
output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = join("", aws_eks_cluster.maagc-eks-cluster.*.id)
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = join("", aws_eks_cluster.maagc-eks-cluster.*.arn)
}

# output "cluster_certificate_authority_data" {
#   description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
#   value       = local.certificate_authority_data

# }

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = join("", aws_eks_cluster.maagc-eks-cluster.*.endpoint)
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = join("", aws_eks_cluster.maagc-eks-cluster.*.version)
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

