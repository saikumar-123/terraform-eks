output "kubeconfig" {
  value       = module.eks_cluster.kubeconfig
  description = "EKS Kubeconfig"
}

output "config-map" {
  value       = module.eks-node-group.config-map-aws-auth
  description = "K8S config map to authorize"
}
#####Cluster Output 
output "eks_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks_cluster.cluster_arn
}

output "eks_cluster_id" {
  description = "The name of the cluster"
  value       = module.eks_cluster.cluster_id
}

output "eks_cluster_version" {
  description = "The Kubernetes server version of the cluster"
  value       = module.eks_cluster.cluster_version
}

# output "cluster_certificate_authority_data" {
#   description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
#   value       = module.eks_cluster.cluster_certificate_authority_data
# }

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks_cluster.cluster_endpoint
}


#######Node Group #######

output "eks_node_group_id" {
  description = "EKS Cluster name and EKS Node Group name separated by a colon"
  value       = module.eks-node-group.eks_node_group_id
}

output "eks_node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = module.eks-node-group.eks_node_group_arn
}

output "eks_node_group_resources" {
  description = "List of objects containing information about underlying resources of the EKS Node Group"
  value       = module.eks-node-group.eks_node_group_resources
}

output "eks_node_group_status" {
  description = "Status of the EKS Node Group"
  value       = module.eks-node-group.eks_node_group_status
}
######################################################

# output "eks_node_group_public_id" {
#   description = "EKS Cluster name and EKS Node Group name separated by a colon"
#   value       = module.eks-node-group.eks_node_group_public_id
# }


# output "eks_node_group_public_arn" {
#   description = "Amazon Resource Name (ARN) of the EKS Node Group"
#   value       = module.eks-node-group.eks_node_group_public_arn
# }

# output "eks_node_group_public_resources" {
#   description = "List of objects containing information about underlying resources of the EKS Node Group"
#   value       = module.eks-node-group.eks_node_group_resources
# }

# output "eks_node_group_public_status" {
#   description = "Status of the EKS Node Group"
#   value       = module.eks-node-group.eks_node_group_public_status
# }


