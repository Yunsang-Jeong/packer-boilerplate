# Overview

Packer를 통해 AWS AMI를 생성하기 위한 템플릿입니다. 인스턴스 설정에 Userdata와 Ansible을 사용하고있습니다.

# How-to-user

packer가 설치되어있어야 합니다.

```bash
packer build -var-file=prd-bastion.pkrvars.hcl .
packer build -var-file=prd-web.pkrvars.hcl .
packer build -var-file=prd-was.pkrvars.hcl .
```

# Configuration

`prd-bastion.pkrvars.hcl`, `prd-web.pkrvars.hcl`, `prd-was.pkrvars.hcl`에 대한 수정이 필요합니다.
