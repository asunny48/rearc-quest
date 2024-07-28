variable "region" {
  default = "us-east-2"
}

variable "ecs_cluster_name" {
  default = "ecs-cluster"
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate to use for TLS"
}
