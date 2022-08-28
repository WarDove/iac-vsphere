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
