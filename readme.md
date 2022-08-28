PKRVARS EXAMPLES FOR PACKER:

variables.auto.pkrvars.hcl =>
##################################################################################
# Vsphere common values
##################################################################################

vcenter_username   = "<your data>"
vcenter_password   = "<your data>"
vcenter_server     = "<your data>1"
vcenter_datacenter = "<your data>"
vcenter_host       = "<your data>"
vcenter_datastore  = "<your data>"
vcenter_network    = "<your data>"

iso_file            = "ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum        = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
vm_guest_os_member  = "server-amd64"
vm_guest_os_version = "20-04-lts"
vm_ipv4             = "<your data>"
vm_gateway          = "<your data>"
vm_mask_bits        = "24"
vm_mask             = "255.255.255.0"
nameservers         = ["8.8.8.8", "8.8.4.4"]


consul.pkrvars.hcl =>
##################################################################################
# Consul machine values
##################################################################################

ssh_username     = "<your data>"
ssh_password     = "<your data>"
vm_password_salt = "16lettersforsalt"
realname         = "Ubuntu user"
vm_cpu_sockets   = "4"
vm_cpu_cores     = "1"
vm_mem_size      = "8192"
vm_disk_size     = "51200"
vm_role          = "consul"
shell_scripts    = ["./scripts/ubuntu_clean.sh"]
packages         = ["openssh-server"]


