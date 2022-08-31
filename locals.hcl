##################################################################################
# Consul Locals
##################################################################################

locals {
  consul_ip_list = [for i in range(1, var.consul_vm_count + 1) : cidrhost(var.vcenter_subnet, i)]
}
##################################################################################
# Vault Locals
##################################################################################

locals {
  vault_ip_list = [for i in range(var.consul_vm_count + 1, var.consul_vm_count + var.vault_vm_count +1) : cidrhost(var.vcenter_subnet, i)]
}

