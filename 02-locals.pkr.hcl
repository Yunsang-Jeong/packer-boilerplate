locals {
  region_splited  = split("-", var.aws_region)
  region_shorthen = "${substr(local.region_splited[0], 0, 1)}${substr(local.region_splited[1], 0, 1)}${substr(local.region_splited[2], 0, 1)}"
  name_tag_middle = "${local.region_shorthen}-${var.project_name}-${var.stage_name}"
}