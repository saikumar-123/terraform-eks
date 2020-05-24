# EKS Terraform module

module "eks_cluster" {
  source                   = "./modules/eks-cluster"
  private_subnet_ids      = var.private_subnet_ids
  # public-subnet-cidr       = var.public-subnet-cidr
  # db-subnet-cidr           = var.db-subnet-cidr
  # eks-cw-logging           = var.eks-cw-logging
  # ec2-key-public-key       = var.ec2-key-public-key

}

data "null_data_source" "wait_for_cluster" {
  inputs = {
    cluster_name             = module.eks_cluster.cluster_id
  }
}


module "eks-node-group" {
  source                   = "./modules/eks-node-group"
  private_subnet_ids         = var.private_subnet_ids
  public_subnet_ids          = var.public_subnet_ids
  cluster_name               = data.null_data_source.wait_for_cluster.outputs["cluster_name"]
  # cluster_certificate_authority_data = module.eks_cluster.cluster_certificate_authority_data
  # cluster_endpoint           = module.eks_cluster.cluster_endpoint
  # ec2-key-public-key       = var.ec2-key-public-key
  # cluster_name       = module.eks_cluster.cluster_id

}

