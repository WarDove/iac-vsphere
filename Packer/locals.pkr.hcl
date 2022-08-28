
##################################################################################
# LOCALS
##################################################################################

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

locals {
  buildnumber = file("${path.root}/content/build.md")
}

locals {
  userdata_template_map = {
    realname          = var.realname
    vm_hostname       = "${var.vm_guest_os_vendor}-${var.vm_role}"
    vm_username       = var.ssh_username
    vm_encrypted_pass = file("/tmp/vm_encrypted_pass")
    vm_ip_addr        = "${var.vm_ipv4}/${var.vm_mask_bits}"
    vm_gateway        = var.vm_gateway
    nameservers       = var.nameservers
    packages          = var.packages
  }
}

locals {
  metadata_template_map = {
    author                   = "AzInDevops"
    build_time               = local.buildtime
    build_number             = local.buildnumber
    datacenter               = var.vcenter_datacenter
    datastrore               = var.vcenter_datastore
    base_image               = var.iso_file
    checksum                 = var.iso_checksum
    os_family                = var.vm_guest_os_family
    os_vendor                = var.vm_guest_os_vendor
    os_member                = var.vm_guest_os_member
    os_version               = var.vm_guest_os_version
    virtual_hardware_version = var.vm_version
    firmware                 = var.vm_firmware
    virtual_resources = {
      cpu_sockets = var.vm_cpu_sockets
      cpu_cores   = var.vm_cpu_cores
      mem_size    = var.vm_mem_size
      disk_size   = var.vm_disk_size
    }
    controller_type   = var.vm_disk_controller_type
    network_card      = var.vm_network_card
    included_packages = var.packages
    machine_role      = var.vm_role
  }
}



