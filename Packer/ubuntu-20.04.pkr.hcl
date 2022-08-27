variable "vcenter_username" {
  type        = string
  description = "The username for authenticating to vCenter."
  default     = "administrator@azininfradev.local"
  #sensitive   = true
}

variable "vcenter_password" {
  type        = string
  description = "The plaintext password for authenticating to vCenter."
  default     = "123456Bb@"
  #sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "The username to use to authenticate over SSH."
  default     = "devops"
  #sensitive   = true
}

variable "ssh_password" {
  type        = string
  description = "The plaintext password to use to authenticate over SSH."
  default     = "Westside592"
  #sensitive   = true
}

# vSphere Objects

variable "vcenter_insecure_connection" {
  type        = bool
  description = "If true, does not validate the vCenter server's TLS certificate."
  default     = true
}

variable "vcenter_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
  default     = "10.180.12.151"
}

variable "vcenter_datacenter" {
  type        = string
  description = "Required if there is more than one datacenter in vCenter."
  default     = "azin-sphere-dc"
}

variable "vcenter_host" {
  type        = string
  description = "The ESXi host where target VM is created."
  default     = "10.180.10.21"
}

variable "vcenter_datastore" {
  type        = string
  description = "Required for clusters, or if the target host has multiple datastores."
  default     = "main-datastore"
}

variable "vcenter_network" {
  type        = string
  description = "The network segment or port group name to which the primary virtual network adapter will be connected."
  default     = "VLAN3513"
}

variable "vcenter_folder" {
  type        = string
  description = "The VM folder in which the VM template will be created."
  default     = "templates"
}

# ISO Objects

variable "iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for ISO images."
  default     = "iso/"
}

variable iso_file {
  type        = string
  description = "The file name of the guest operating system ISO image installation media."
  default = "ubuntu-20.04.4-live-server-amd64.iso"
}

variable "iso_checksum" {
  type        = string
  description = "The SHA-256 checkcum of the ISO image."
  default     = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
}

# HTTP Endpoint

variable "http_directory" {
  type        = string
  description = "Directory of config files(user-data, meta-data)."
  default     = "http"
}

# Virtual Machine Settings

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family."
  default     = "linux"
}

variable "vm_guest_os_vendor" {
  type        = string
  description = "The guest operating system vendor."
  default     = "ubuntu"
}

variable "vm_guest_os_member" {
  type        = string
  description = "The guest operating system member."
  default     = "desktop-amd64"
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version."
  default     = "20-04-lts"
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid."
  default     = "ubuntu64Guest"
}

variable vm_version {
  type        = number
  description = "The VM virtual hardware version."
  default     = "14"
  # https://kb.vmware.com/s/article/1003746
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'bios' or 'efi')"
  default     = "bios"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type."
  default     = "sata"
}

variable "vm_cpu_sockets" {
  type        = number
  description = "The number of virtual CPUs sockets."
  default     = "4"
}

variable "vm_cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket."
  default     = "1"
}

variable "vm_mem_size" {
  type        = number
  description = "The size for the virtual memory in MB."
  default     = "8192"
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB."
  default     = "51200"
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence."
  default     = ["pvscsi"]
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type."
  default     = "vmxnet3"
}

variable "vm_boot_wait" {
  type        = string
  description = "The time to wait before boot. "
  default     = "2s"

}

variable "shell_scripts" {
  type        = list(string)
  description = "A list of scripts."
  default     = ["./scripts/setup_ubuntu2004.sh"]
}

##################################################################################
# LOCALS
##################################################################################

locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

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
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."
  vm_name              = "${var.vm_guest_os_family}-${var.vm_guest_os_vendor}-${var.vm_guest_os_member}-${var.vm_guest_os_version}-test"
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
  iso_paths      = ["[${var.vcenter_datastore}] /${var.iso_path}/${var.iso_file}"]
  iso_checksum   = "sha512:var.iso_checksum"
  http_directory = var.http_directory
  boot_order     = "disk,cdrom"
  boot_wait      = var.vm_boot_wait
  boot_command   = [
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
