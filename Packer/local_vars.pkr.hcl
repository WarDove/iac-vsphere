##################################################################################
# Template specific variables
##################################################################################

variable "shell_scripts" {
  type        = list(string)
  description = "A list of scripts."
  default     = ["./scripts/ubuntu_clean.sh"]
}

variable "packages" {
  type        = list(string)
  description = "Packages for the templete"
  default     = ["openssh-server"]
}

variable "vm_route_targets" {
  type        = list(string)
  description = "Routing targets"
  default     = ["10.70.0.0/24"]
}

variable "vm_route_gw" {
  type        = string
  description = "Routing Gateway"
  default     = "10.180.12.1"
}

variable "vm_role" {
  type        = string
  description = "Role of the machine"
  default     = "machine"
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
  default     = "4096"
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB."
  default     = "51200"
}
