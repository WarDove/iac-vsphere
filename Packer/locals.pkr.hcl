
##################################################################################
# LOCALS
##################################################################################

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}


locals {
  userdata_template_map = {
    realname          = var.realname
    vm_hostname       = "${var.vm_guest_os_vendor}-${var.vm_role}"
    vm_username       = var.ssh_username
    vm_encrypted_pass = file("/tmp/vm_encrypted_pass")
    #vm_encrypted_pass = var.vm_encrypted_pass
    vm_ip_addr  = "${var.vm_ipv4}/${var.vm_mask_bits}"
    vm_gateway  = var.vm_gateway
    nameservers = var.nameservers
    packages    = var.packages
  }
}

locals { 
 build_number = file("${path.root}/content/build.md")
 }


