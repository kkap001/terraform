variable "env" {
  description = "Depolyment environment"
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

#variable "env" {
 # description = "Depolyment environment"
##  default     = "dev"
#}

variable "repository_branch" {
  description = "Repository branch to connect to"
  default     = "master"
}

variable "repository_name" {
  default = "angularcase"
  description     = "my test angular repo"
}

variable "static_web_bucket_name" {
  description = "S3 Bucket to deploy to"
  default     = "myangularcode1"
}

variable "artifacts_bucket_name" {
  description = "S3 Bucket for storing artifacts"
  default     = "artifacts-bucket"
}