# ebraekke/oci-mysql-intro

# Intro 

This is the first version of a terraform suite that creates a MySQL DB System (aka InnoDB CLuster) inside a VCN. 

The created config is used by the repo `ebraekke/oci-powershell-modules`.

TODO: Add more documentation. 

## Usage

Store config files in sub-dir `config/` it is ignored by git.

```
terraform plan --out=oci-mysql-intro.tfplan --var-file=config/vars_fra.tfvars

terraform apply ....
```
