# oci-mysql-intro

I have one Bastion servcie with private IP:

Bastion:
10.0.0.49/32	All my MySQL ports via bastion

Ports: 3306,33060,33061

I have one private endpoint with `Reverse connection source IPs` 

Private Endpoint
10.0.0.45/32	All my MySQL ports via private endpoint part1
10.0.0.182/32	All my MySQL ports via private endpoint part2


Ports: 3306,33060,33061

# Usage

Store config files in sub-dir `config/` it is ignored by git.

terraform plan --out=oci-mysql-intro.tfplan --var-file=config/vars_fra.tfvars

terraform apply ....
