# EKS Cluster Variables Configuration

variable "cluster_name" {
  default     = "maagc-eks-cluster"
  type        = string
  description = "The name of your EKS Cluster"
}

variable "k8s-version" {
  default     = "1.14"
  type        = string
  description = "Required K8s version"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "enable_cluster_autoscaler" {
  type        = bool
  description = "Whether to enable node group to scale the Auto Scaling Group"
  default     = false
}

variable "private_subnet_ids" {
  type        = list
  description = "Private Subnet IDS"
}

variable "public_subnet_ids" {
  type        = list
  description = "Public Subnet IDS"
}

variable "module_depends_on" {
  type        = any
  default     = "eks_cluster"
  description = "Can be any value desired. Module will wait for this value to be computed before creating node group."
}

variable "node_group_role" {
  description = "EKS worker Node group Role (aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy)"
  type        = string
  default     = "maagc-eks-worker-role"
}

locals {
    common_tags = map(
        "Application", "maagc",
        "CostCenter", "0480",
        "ResourceOwner", "sai.doppalapudi"
    )
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to `AL2_x86_64`. Valid values: `AL2_x86_64`, `AL2_x86_64_GPU`. Terraform will only perform drift detection if a configuration value is provided"
  default     = "AL2_x86_64"
}

variable "maagc_node_instance_type" {
  default     = ["t3.xlarge"]
  type        = list(string)
  description = "Worker Node EC2 instance type"
}

variable "root_block_size" {
  default     = "100"
  type        = string
  description = "Size of the root EBS block device"

}

variable "desired_capacity" {
  default     = 1
  type        = string
  description = "Autoscaling Desired node capacity"
}

variable "max_size" {
  default     = 5
  type        = string
  description = "Autoscaling maximum node capacity"
}

variable "min_size" {
  default     = 1
  type        = string
  description = "Autoscaling Minimum node capacity"
}

variable "kubernetes_labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  default     = {}
}

variable "ec2_key_name" {
  default     = "maagc-eks"
  type        = string
  description = "SSH key pair name to login to worker nodes"
}

# variable "maagc_node_instance_profile" {
#   default = "ec2_role_for_maagc"
#   type  = string
#   description = "Profile to have access to AmazonEKSWorkerNodePolicy,AmazonEKS_CNI_Policy,AmazonEC2ContainerRegistryReadOnly policies"
# }

# variable "kublet-extra-args" {
#   default     = ""
#   type        = string
#   description = "Additional arguments to supply to the node kubelet process"
# }

# variable "public-kublet-extra-args" {
#   default     = ""
#   type        = string
#   description = "Additional arguments to supply to the public node kubelet process"

# }
