variable "region" {
    description = "target AWS region to create resources"
    type        = string
    default     = "us-east-1"
}

variable "prefix" {
    description = "application name"
    type        = string
    default     = "asha-pre"
}

variable "bucket_name" {
    description = "bucket name"
    type        = string
    default     = "asha"
}

variable "tags" {
  type = map(string)
  description = "Tags to be added with all the resources"
     default     = {
        environment = "prod"
        terraform   = "true"
        }    
}