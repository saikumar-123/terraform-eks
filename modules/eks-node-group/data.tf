data "aws_iam_role" "nodegroup" {
  name = "${var.node_group_role}"
}
data "aws_security_groups" "nodegroup_security_groups" {
  tags = {
    Application = "maagc"
    CostCenter = "0480"
  }
}

locals {
  tags = merge(
    local.common_tags,
    {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    },
    {
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    },
    {
      "k8s.io/cluster-autoscaler/enabled" = "${var.enable_cluster_autoscaler}"
    },
    {
      "Name" = "${var.cluster_name}-node-group"
    }

  )
}

# data "aws_ami" "maagc_eks_worker_ami" {
#   executable_users = ["self"]
#   most_recent      = true
#   name_regex       = "^amazon-eks-node-[1-9,\\.]+-v\\d{8}$"
#   owners           = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-*"]
#   }
# }

# data "aws_caller_identity" "maagcaccount" {}

# data "aws_ami" "maagc-eks-worker-ami" {
#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-${var.k8s-version}-*"]
#   }

#   most_recent = true
#   owners      = "{data.aws_caller_identity.maagcaccount.account_id}" # Amazon
# }

# locals {
#   eks-public-node-userdata = <<USERDATA
# #!/bin/bash
# set -o xtrace
# /etc/eks/bootstrap.sh --apiserver-endpoint '${cluster_endpoint}' --b64-cluster-ca '${cluster_certificate_authority_data}' '${var.cluster-name}' --kubelet-extra-args '${var.public-kublet-extra-args}'
# USERDATA
# }

# locals {
#   eks-node-userdata = <<USERDATA
# #!/bin/bash
# set -o xtrace
# /etc/eks/bootstrap.sh --apiserver-endpoint '${cluster_endpoint}' --b64-cluster-ca '${cluster_certificate_authority_data}' '${var.cluster-name}' --kubelet-extra-args '${var.kublet-extra-args}'
# USERDATA
# }

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${data.aws_iam_role.nodegroup.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}
