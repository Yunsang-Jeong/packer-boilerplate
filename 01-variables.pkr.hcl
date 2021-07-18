########################################
# AWS Credential
variable "aws_profile" {
  type    = string
  default = ""
}

variable "aws_region" {
  description = "[Requried]"
  type        = string
  default     = "ap-northeast"
}

variable "aws_access_key" {
  type    = string
  default = null
}

variable "aws_secret_key" {
  type    = string
  default = null
}

variable "assume_role_arn" {
  type    = string
  default = null
}

variable "assume_role_session_name" {
  type    = string
  default = null
}

variable "assume_role_external_id" {
  type    = string
  default = null
}
########################################


########################################
# Name tag convention
variable "project_name" {
  type    = string
  default = "FFFF"
}

variable "stage_name" {
  type    = string
  default = "FFFF"
}

variable "image_name" {
  type    = string
}
########################################


########################################
# Source image
variable "source_ami_id" {
  type    = string
  default = null
}

variable "source_ami_filter_most_recent" {
  type    = string
  default = null
}

variable "source_ami_filter_owners" {
  type    = string
  default = null
}

variable "source_ami_filter_name" {
  type    = string
  default = null
}

variable "source_ami_filter_root-device-type" {
  type    = string
  default = null
}

variable "virtualization-type" {
  type    = string
  default = null
}
########################################


########################################
# Source image network
variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "subnet_name_tag_postfix" {
  type    = string
  default = ""
}

variable "use_bastion_host" {
  type    = bool
  default = false
}

variable "ssh_bastion_host" {
  type    = string
  default = ""
}

variable "ssh_bastion_port" {
  type    = number
  default = 0
}

variable "ssh_bastion_agent_auth" {
  type    = bool
  default = false
}

variable "ssh_bastion_username" {
  type    = string
  default = ""
}

variable "ssh_bastion_password" {
  type    = string
  default = ""
  sensitive = true
}
########################################


########################################
# Source image settings
variable "block_devices" {
  type    = set(object({
    device_name = string
    volume_type = string
    volume_size = number
    iops = number
    throughput = number
    delete_on_termination = bool
  }))
  default = []
}

variable "iam_instance_profile" {
  type    = string
  default = ""
}

variable "security_group_ids" {
  type    = set(string)
  default = []
}
########################################


########################################
# System account and New SSH Service port
variable "mgmt_user_name" {
  type = string
}

variable "mgmt_user_password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "mgmt_ssh_port" {
  type    = number
  default = 22
}
########################################


########################################
# Ansible
variable "ansible_playbook" {
  type = string
  default = ""
}

variable "ansible_role_path" {
  type = string
  default = ""
}

variable "ansible_parameters" {
  type = map(string)
  default = {}
}
########################################