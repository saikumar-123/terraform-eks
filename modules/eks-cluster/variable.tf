# EKS Cluster Variables Configuration

variable "cluster_name" {
  default     = "maagc-eks-cluster"
  type        = string
  description = "The name of your EKS Cluster"
}

variable "aws-region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}

variable "k8s-version" {
  default     = "1.16"
  type        = string
  description = "Required K8s version"
}

variable "private_subnet_ids" {
  type        = list
  description = "Private Subnet IDS"
}

variable "cluster_role" {
  description = "EKS Cluster Role"
  type        = string
  default     = "EKS-Clusterrole"
}

# variable "node_group_role" {
#   description = "EKS worker Node group Role (aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy)"
#   type        = string
#   default     = "EKS_Role_maagc"
# }

# variable "workers_role_arns" {
#   type        = list(string)
#   description = "List of Role ARNs of the worker nodes"
#   default     = []
# }

locals {
    common_tags = map(
        "Application", "maagc",
        "CostCenter", "0480",
        "ResourceOwner", "sai.doppalapudi"
    )
}

####### configuration for EKS Cluster

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "apply_config_map_aws_auth" {
  type        = bool
  default     = true
  description = "Whether to apply the ConfigMap to allow worker nodes to join the EKS cluster and allow additional users, accounts and roles to acces the cluster"
}

variable "local_exec_interpreter" {
  type        = list(string)
  default     = ["/bin/sh", "-c"]
  description = "shell to use for local_exec"
}

variable "wait_for_cluster_command" {
  type        = string
  default     = "curl --silent --fail --retry 60 --retry-delay 5 --retry-connrefused --insecure --output /dev/null $ENDPOINT/healthz"
  description = "`local-exec` command to execute to determine if the EKS cluster is healthy. Cluster endpoint are available as environment variable `ENDPOINT`"
}

variable "kubernetes_config_map_ignore_role_changes" {
  type        = bool
  default     = true
  description = "Set to `true` to ignore IAM role changes in the Kubernetes Auth ConfigMap"
}

# #### Adding users to kubeconfig 

variable "map_additional_aws_accounts" {
  description = "Additional AWS account numbers to add to `config-map-aws-auth` ConfigMap"
  type        = list(string)
  default     = []
}

variable "map_additional_iam_users" {
  description = "Additional IAM users to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

#########Cloudwatch logs for EKS cLuster

variable "enabled_cluster_log_types" {
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  type        = list
  description = "Enable EKS CloudWatch Logs for EKS components"
}

variable "cluster_log_retention_period" {
  type        = number
  default     = 1
  description = "Number of days to retain cluster logs. Requires `enabled_cluster_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html."
}



