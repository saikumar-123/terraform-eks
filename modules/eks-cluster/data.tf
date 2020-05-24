data "aws_iam_role" "cluster" {
  name = "${var.cluster_role}"
}

data "aws_security_groups" "cluster_security_groups" {
  tags = {
    Application = "maagc"
    CostCenter = "0480"
  }
}



locals {

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.maagc-eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.maagc-eks-cluster.certificate_authority.0.data}
  name: ${var.cluster_name}
contexts:
- context:
    cluster: ${var.cluster_name}
    user: ${var.cluster_name}
  name: ${var.cluster_name}
current-context: ${var.cluster_name}
kind: Config
preferences: {}
users:
- name: ${var.cluster_name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - "${var.cluster_name}"
        - "--region"
        - "${var.aws-region}"
KUBECONFIG
}
