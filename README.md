
![Logo](https://s3.eu-central-1.amazonaws.com/huseynov.tarlan/devops-black.png)
#  HCL-Vsphere-Infra

Hands-On Ready IaC for Vsphere, Terraform and Packer stack


# Acknowledgements

Only ubuntu-server 20.04 lts version OS user-data and os specific configurations should be considered for this module.
All sensible value containing extensions (.tfstate, .pkvars, .tfvars)should be treated as a secret.

## Deployment
- Install Terraform ~ v1.2.7
- Install Packer ~ v1.8.3
- Clone the repository
To deploy this project you should set general aggregated variables for both tools in root folder.
Also for packer additional local variable values should be set for each type of packer template (i.e consul.pkr.hcl - containing values for consul server)
## Consolidated inputs:
- File containing input variables for Terraform `variables.tf` should be created as a symlink to the `variables.hcl` file in root folder.
- File containing input variables for Packer `variables.pkr.hcl` should be created as a symlink to the `variables.hcl` file in root folder.
---
- File containing input variable values for Terraform `terraform.tfvars` should be created as a symlink to the `values.hcl` file in root folder.
- File containing input variable values for Packer `packer.auto.pkrvars.hcl` should be created as a symlink to the `values.hcl` file in root folder.











## Usage/Examples

Packer scripts should be launched only with bash executable -> `packer-build`

Data containin file examples are shown below.

```hcl
"values.hcl" in root folder

##################################################################################
# Vsphere common values
##################################################################################
vcenter_username   = "some_user@infradev.local"
vcenter_password   = "somepassword"
vcenter_datacenter = "vsphere-dc"
vcenter_datastore  = "datastore"
vcenter_network    = "VLAN3513"
vcenter_host       = "10.10.10.3"
vcenter_server     = "10.10.10.4"
vcenter_subnet     = "10.10.20.0/24"
##################################################################################
# Template common values
##################################################################################
iso_file            = "ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum        = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
vm_guest_os_member  = "server-amd64"
vm_guest_os_version = "20-04-lts"
vm_ipv4             = "10.10.20.2"
vm_gateway          = "10.10.20.1"
vm_mask_bits        = "24"
vm_mask             = "255.255.255.0"
vm_password_salt    = "saltwhichholds16"
nameservers         = ["8.8.8.8", "8.8.4.4"]
ssh_username        = "devops"
ssh_password        = "YouShallNotPass!"
realname            = "Tarlan Huseynov"
```

```hcl
"consul.pkvars.hcl" in Packer folder
##################################################################################
# Consul machine values
##################################################################################
vm_cpu_sockets   = "4"
vm_cpu_cores     = "1"
vm_mem_size      = "8192"
vm_disk_size     = "51200"
vm_role          = "consul"
vm_route_gw      = "10.10.20.1"
vm_route_targets = ["10.10.30.1/32", "10.10.30.2/3", "10.10.30.3/3"]
shell_scripts    = ["./scripts/consul_setup.sh", "./scripts/add_routes.sh", "./scripts/ubuntu_clean.sh"]
packages         = ["openssh-server"]
```


## Installation
[Terraform](https://www.terraform.io/downloads)

[Packer](https://www.packer.io/downloads)

    
