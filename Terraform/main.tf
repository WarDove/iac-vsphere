##################################################################################
# General Data
##################################################################################

# Get DataCenter date from vcenter
data "vsphere_datacenter" "main-dc" {
  name = var.vcenter_datacenter
}

# Get Datastore date from vcenter
data "vsphere_datastore" "main-datastore" {
  name          = var.vcenter_datastore
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Get Network data from vcenter
data "vsphere_network" "vm-network" {
  name          = var.vcenter_network
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Locate target Resource Pool
data "vsphere_resource_pool" "target-resource-pool" {
  name          = "${var.vcenter_host}/Resources/"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

##################################################################################
# Consul Servers
##################################################################################

# Get template for consul created by packer
data "vsphere_virtual_machine" "consul-template" {
  name          = var.consul_template_name
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Provision consul machines
resource "vsphere_virtual_machine" "consul-vm" {
  count            = 1
  name             = "${var.consul_machine_hostname}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.target-resource-pool.id
  datastore_id     = data.vsphere_datastore.main-datastore.id
  num_cpus         = 2
  #num_cpus         = data.vsphere_virtual_machine.consul-template.num_cpus
  memory = 4096
  #memory           = data.vsphere_virtual_machine.consul-template.memory
  guest_id  = data.vsphere_virtual_machine.consul-template.guest_id
  scsi_type = data.vsphere_virtual_machine.consul-template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.vm-network.id
    adapter_type = data.vsphere_virtual_machine.consul-template.network_interface_types[0]
  }
  disk {
    label            = data.vsphere_virtual_machine.consul-template.disks.0.label
    size             = data.vsphere_virtual_machine.consul-template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.consul-template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.consul-template.id
    customize {
      linux_options {
        host_name = "${var.consul_machine_hostname}-${count.index + 1}"
        domain    = "consul.local"
      }
      network_interface {
        ipv4_address = local.consul_ip_list[count.index]
        ipv4_netmask = var.vm_mask_bits
      }
      ipv4_gateway = var.vm_gateway
    }
  }
}

