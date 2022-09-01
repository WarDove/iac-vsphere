##################################################################################
# Vsphere variables
##################################################################################

variable "vcenter_username" {
  type        = string
  description = "The username for authenticating to vCenter."
  sensitive   = true
}

variable "vcenter_password" {
  type        = string
  description = "The plaintext password for authenticating to vCenter."
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "The username to use to authenticate over SSH."
  default     = "ubuntu"
  sensitive   = true
}

variable "ssh_password" {
  type        = string
  description = "The plaintext password to use to authenticate over SSH."
  default     = "ubuntu"
  sensitive   = true
}

variable "vcenter_insecure_connection" {
  type        = bool
  description = "If true, does not validate the vCenter server's TLS certificate."
  default     = true
}

variable "vcenter_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vcenter_subnet" {
  type        = string
  description = "Allocated subnet for provisioned machines."
}

variable "vcenter_datacenter" {
  type        = string
  description = "Required if there is more than one datacenter in vCenter."
  default     = "azin-sphere-dc"
}

variable "vcenter_host" {
  type        = string
  description = "The ESXi host where target VM is created."
}

variable "vcenter_datastore" {
  type        = string
  description = "Required for clusters, or if the target host has multiple datastores."
}

variable "vcenter_network" {
  type        = string
  description = "The network segment or port group name to which the primary virtual network adapter will be connected."
}

variable "vcenter_folder" {
  type        = string
  description = "The VM folder in which the VM template will be created."
  default     = "templates"
}

##################################################################################
# ISO variables
##################################################################################

variable "iso_path" {
  type        = string
  description = "The path on the source vSphere datastore for ISO images."
  default     = "iso/"
}

variable "iso_file" {
  type        = string
  description = "The file name of the guest operating system ISO image installation media."
}

variable "iso_checksum" {
  type        = string
  description = "The SHA-256 checkcum of the ISO image."
}

##################################################################################
# VM common variables
##################################################################################

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
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version."
}

variable "vm_guest_os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid."
  default     = "ubuntu64Guest"
}

variable "vm_version" {
  type        = number
  description = "The VM virtual hardware version."
  default     = "14"
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

variable "vm_ipv4" {
  type        = string
  description = "Ip for the temporary template VM"
}

variable "vm_gateway" {
  type        = string
  description = "Gateway of the temporary VM"
}

variable "vm_mask_bits" {
  type        = string
  description = "Subnet mask representation in bits"
}

variable "vm_mask" {
  type        = string
  description = "Subnet representation"
}

variable "nameservers" {
  type        = list(string)
  description = "Nameservers for the temporary template VM"
}

variable "vm_password_salt" {
  type        = string
  description = "salt for password encryption"
  default     = "16lettersforsalt"
  sensitive   = true
}

variable "realname" {
  type        = string
  description = "User Realname"
  default     = "Ubuntu User"
}

variable "vm_hostname" {
  type        = string
  description = "VM hostname"
  default     = "ubuntu"
}

variable "admin_ipv4_list" {
  type        = list(string)
  description = "Ip list of administrative hosts"
}

##################################################################################

##################################################################################
# Consul Machine variables
##################################################################################

variable "consul_vm_count" {
  type        = number
  description = "Number of machines in consul cluster"
  default     = 3
}

variable "consul_template_name" {
  type        = string
  description = "The name of the template for Consul machine."
  default     = "ubuntu-20-04-lts-consul-build:latest"
}

variable "consul_machine_hostname" {
  type        = string
  description = "The conventional hostname for the Consul machines."
  default     = "consul-server"
}

##################################################################################
# Vault Machine variables
##################################################################################

variable "vault_vm_count" {
  type        = number
  description = "Number of machines in vault cluster"
  default     = 2
}

variable "vault_template_name" {
  type        = string
  description = "The name of the template for Consul machine."
  default     = "ubuntu-20-04-lts-vault-build:latest"
}

variable "vault_machine_hostname" {
  type        = string
  description = "The conventional hostname for the Consul machines."
  default     = "vault-server"
}

