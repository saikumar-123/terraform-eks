# Variables Configuration


variable "aws-region" {
  default     = "us-east-1"
  type        = string
  description = "The AWS Region to deploy EKS"
}


# variable "k8s-version" {
#   default     = "1.13"
#   type        = string
#   description = "Required K8s version"
# }


variable "private_subnet_ids" {
  type        = list
  description = "Private Subnet IDS"
}

variable "public_subnet_ids" {
  type        = list
  description = "Public Subnet IDS"
}
