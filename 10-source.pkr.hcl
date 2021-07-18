locals {
  ami_tags = {
    "Name"      = "ami-${local.name_tag_middle}-${var.image_name}"
    "BuildTime" = timestamp()
  }
}

#
# These parameters can be overwrite by build block!
#
source "amazon-ebs" "this" {
  ########################################
  # AWS Credential
  region     = var.aws_region
  profile    = var.aws_profile
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  dynamic assume_role {
    for_each = var.assume_role_arn == null ? [] : [1]

    content {
      role_arn     = var.assume_role_arn
      session_name = var.assume_role_session_name
      external_id  = var.assume_role_external_id
    }
  }
  ########################################

  ########################################
  # Output
  ami_name = "ami-${local.name_tag_middle}-${var.image_name}"
  dynamic tag {
    for_each = local.ami_tags

    content {
      key   = tag.key
      value = tag.value
    }
  }
  ########################################

  ########################################
  # Source AMI
  source_ami = var.source_ami_id
  dynamic source_ami_filter {
    for_each = var.source_ami_filter_name == null ? [] : [1]

    content {
      most_recent = var.source_ami_filter_most_recent
      owners      = [var.source_ami_filter_owners]
      filters = {
        name                = var.source_ami_filter_name 
        root-device-type    = var.source_ami_filter_root-device-type
        virtualization-type = var.virtualization-type
      }
    }
  }
  ########################################

  ########################################
  # Source instance

  ## Network
  security_group_ids = var.security_group_ids == [] ? null : var.security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  dynamic subnet_filter {
    for_each = var.subnet_name_tag_postfix == "" ? [] : [var.subnet_name_tag_postfix]
    content {
      filters = {
        "tag:Name": "sub-${local.name_tag_middle}-${subnet_filter.value}"
      }
      random = false
    }
  }

  ## Volume
  dynamic launch_block_device_mappings {
    for_each = var.block_devices
    content {
      device_name = launch_block_device_mappings.value["device_name"]
      volume_size = launch_block_device_mappings.value["volume_size"]
      volume_type = launch_block_device_mappings.value["volume_type"]
      throughput = launch_block_device_mappings.value["throughput"]
      iops = launch_block_device_mappings.value["iops"]
      delete_on_termination = launch_block_device_mappings.value["delete_on_termination"]
    }
  }
  ########################################

  ########################################
  # Connect
  communicator = "ssh"
  
  ssh_port     = var.mgmt_ssh_port
  ssh_username = var.mgmt_user_name
  ssh_password = var.mgmt_user_password != "" ? var.mgmt_user_password : null

  # pause_before_connecting = "60s"

  ssh_bastion_host = var.use_bastion_host ? var.ssh_bastion_host : null
  ssh_bastion_port = var.use_bastion_host ? var.ssh_bastion_port : null
  ssh_bastion_agent_auth = var.use_bastion_host ? var.ssh_bastion_agent_auth : null
  ssh_bastion_username = var.use_bastion_host ? var.ssh_bastion_username : null
  ssh_bastion_password = var.use_bastion_host ? var.ssh_bastion_password : null
  ########################################

  ########################################
  # Build instance
  instance_type = "t3.nano"
  iam_instance_profile = var.iam_instance_profile == "" ? null : var.iam_instance_profile
  # temporary_iam_instance_profile_policy_document {
  #   Version = "2012-10-17"
  #   Statement {
  #     Action   = ["ssm:*"]
  #     Effect   = "Allow"
  #     Resource = "*"
  #   }
  #   Statement {
  #     Action   = ["kms:*"]
  #     Effect   = "Allow"
  #     Resource = "*"
  #   }
  #   Statement {
  #     Action   = ["ec2:*"]
  #     Effect   = "Allow"
  #     Resource = "*"
  #   }
  # }
  ########################################
}