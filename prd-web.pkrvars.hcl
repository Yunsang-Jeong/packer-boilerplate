########################################
# AWS Credential
aws_profile = "default"
aws_region  = "ap-northeast-2"
########################################

########################################
# Name tag convention
project_name = "myservice"
stage_name   = "prd"
image_name   = "web-general"
########################################

########################################
# Source AMI
source_ami_filter_most_recent         = true
source_ami_filter_owners              = "amazon"
source_ami_filter_name                = "amzn2-ami-hvm-*"
source_ami_filter_root-device-type    = "ebs"
virtualization-type                   = "hvm"
block_devices = [{
    device_name = "/dev/xvda"
    volume_type = "gp3"
    volume_size = "20"
    iops = 3000
    throughput = 125
    delete_on_termination = false
}]
associate_public_ip_address           = false
subnet_name_tag_postfix               = "Subnet의 identifier"
security_group_ids                    = ["부여할 Security group id"]
iam_instance_profile                  = "인스턴스에 부여할 profile name"
########################################

########################################
# Bastion host
use_bastion_host = true
ssh_bastion_host = "베스천호스트의IP를입력합니다."
ssh_bastion_port = 42643
ssh_bastion_agent_auth = false
ssh_bastion_username = "yunsang"
ssh_bastion_password = "P@SSWORD"
########################################

########################################
# System account and New SSH Service port
mgmt_user_name     = "webweb"
mgmt_user_password = "P@SSWORD"
mgmt_ssh_port      = 42643
########################################

########################################
# Ansible
ansible_playbook = "./ansible-playbook/playbook-web.yaml"
ansible_role_path = "./ansible-role/"
# ansible_parameters = {}
########################################