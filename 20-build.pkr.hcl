locals {
  build_instance_tags = {
    "Name" = "packer-${local.name_tag_middle}-${var.image_name}"
  }
}

build {
  name = "this"

  source "amazon-ebs.this" {
    user_data = templatefile("templates/create-new-user.pkrtpl.hcl", {
      mgmt_user_name     = var.mgmt_user_name,
      mgmt_user_password = var.mgmt_user_password,
      mgmt_ssh_port      = var.mgmt_ssh_port
    })

    dynamic run_tag {
      for_each = local.build_instance_tags
      content {
        key   = run_tag.key
        value = run_tag.value
      }
    }
  }

  provisioner "ansible" {
    command       = "ansible-playbook"
    playbook_file = var.ansible_playbook
    roles_path    = var.ansible_role_path
    extra_arguments = length(var.ansible_parameters) == 0 ? null : flatten(["--extra-vars", join(" ", [for k ,v in var.ansible_parameters : "${k}=${v}"])])
  }
}