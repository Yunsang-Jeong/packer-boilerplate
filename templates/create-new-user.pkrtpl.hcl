#!/bin/bash

USER_NAME='${mgmt_user_name}'
USER_PASS='${mgmt_user_password}'
SSH_PORT='${mgmt_ssh_port}'

useradd $USER_NAME --create-home
echo $USER_NAME:$USER_PASS | chpasswd
echo $USER_NAME' ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/50-management-user

sed -i 's/^#\{0,1\}\(Port\).\{1,\}$/\1 '$SSH_PORT'/' /etc/ssh/sshd_config
sed -i 's/^#\{0,1\}\(PasswordAuthentication\).\{1,\}$/\1 yes/' /etc/ssh/sshd_config
sed -i 's/#\{0,1\}\(ssh_pwauth:\).\{1,\}$/\1 true/' /etc/cloud/cloud.cfg
service sshd restart