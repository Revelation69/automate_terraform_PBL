variable "efs-subnet-2" {
  description = "Second subnet for the mount target"
}

variable "efs-subnet-1" {
  description = "First subnet for the mount target"
}

variable "efs-sg" {
  type        = list
  description = "security group for the file system"

}

variable "efs-name" {
  type        = string
  description = "efs name"

}

variable "efs-wordpress-root-directory" {
  type = string
  description = "wordpress root directory"
}

variable "efs-tooling-root-directory" {
  type = string
  description = "tooling root directory"
}



variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}