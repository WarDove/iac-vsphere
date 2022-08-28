##################################################################################
# SOURCE
##################################################################################

source "vsphere-iso" "linux-ubuntu-server" {
  vcenter_server       = var.vcenter_server
  username             = var.vcenter_username
  password             = var.vcenter_password
  datacenter           = var.vcenter_datacenter
  datastore            = var.vcenter_datastore
  host                 = var.vcenter_host
  folder               = var.vcenter_folder
  insecure_connection  = var.vcenter_insecure_connection
  tools_upgrade_policy = true
  remove_cdrom         = true
  convert_to_template  = true
  guest_os_type        = var.vm_guest_os_type
  vm_version           = var.vm_version
  notes                = "Built by HashiCorp Packer on ${local.buildtime}. Author: AzInDevops"
  vm_name              = "${var.vm_guest_os_vendor}-${var.vm_guest_os_version}-${var.vm_role}-build:${local.buildnumber}"
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_sockets
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = false
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = false
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size             = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
  }
  iso_paths     = ["[${var.vcenter_datastore}] /${var.iso_path}/${var.iso_file}"]
  iso_checksum  = "sha512:var.iso_checksum"
  http_port_min = 8080
  http_port_max = 8080
  http_content = {
    "/meta-data" = file("content/meta-data")
    "/user-data" = file("content/user-data")
  }
  boot_order = "disk,cdrom"
  boot_wait  = var.vm_boot_wait
  boot_command = [
    "<esc><enter><f6><esc><wait> ",
    "<bs><bs><bs><bs><bs>",
    "ip=10.180.12.155::10.180.12.20:255.255.255.0::::8.8.8.8:8.8.4.4 ",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <enter>"
  ]
  ip_wait_timeout        = "20m"
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_port               = 22
  ssh_timeout            = "60m"
  ssh_handshake_attempts = "100000"
  shutdown_command       = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout       = "15m"
}

##################################################################################
# BUILD
##################################################################################

build {
  name = "step-3"
  sources = [
  "source.vsphere-iso.linux-ubuntu-server"]
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    environment_vars = [
      "BUILD_USERNAME=${var.ssh_username}",
    ]
    scripts           = var.shell_scripts
    expect_disconnect = true
  }
}
