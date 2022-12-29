# oci-mysql-intro


# Usage

Store config files in sub-dir `config/` it is ignored by git.

terraform plan --out=oci-mysql-intro.tfplan --var-file=config/vars_fra.tfvars

terraform apply ....
