variable "docker_repo_name" {
  default     = "miguel/jenkins"
  type        = string
  description = "The docker repo name"
}

variable "jenkins_user_pwd" {
  description = "The Jenkins User Password"
  type        = string
  default     = "Testing"
}

variable "jenkins_port" {
  description = "The Jenkins port number"
  type        = number
  default     = 7070
}

variable "bitbucket_access_token" {
  description = "The BitButcket Acccess Token"
  type        = string
  default     = "MjEyODIzNjU2Mjc4Orx9MKgwYCcSeQCUGHduNMO0Wb5r"
}

variable "bitbucket_user_pwd" {
  description = "The BitBucket User Password"
  type        = string
  default     = "Testing"
}

variable "bitbucket_url" {
  description = "The BitBucket Url"
  type        = string
  default     = "http://172.17.0.1:7990"
}
