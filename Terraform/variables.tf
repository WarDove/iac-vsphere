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

variable "vcenter_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vcenter_datacenter" {
  type        = string
  description = "Required if there is more than one datacenter in vCenter."
  default     = "azin-sphere-dc"
}
variable "vcenter_datastore" {
  type        = string
  description = "Required for clusters, or if the target host has multiple datastores."
}

variable "vcenter_network" {
  type        = string
  description = "The network segment or port group name to which the primary virtual network adapter will be connected."
}

variable "vcenter_host" {
  type        = string
  description = "The ESXi host where target VM is created."
}

##################################################################################
# Consul Machine variables
##################################################################################

variable "consul_template_name" {
  type        = string
  description = "The name of the template for Consul machine."
  default     = "ubuntu-20-04-lts-consul-build:latest"
}

variable "consul_machine_hostname" {
  type        = string
  description = "The conventional hostname for the Consul machines."
  default     = "Consul-Machine"
}
