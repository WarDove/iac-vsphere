##################################################################################
# Consul machine values
##################################################################################

ssh_username="devops"
ssh_password="Westside592"
vm_password_salt = "qezenfer12345678"
realname = "DevOps unit"
vm_cpu_sockets="4"
vm_cpu_cores="1"
vm_mem_size="8192"
vm_disk_size="51200"
vm_role = "consul"
shell_scripts=["./scripts/ubuntu_clean.sh"]
packages = ["openssh-server"]
