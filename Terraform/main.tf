data "vsphere_datacenter" "main-dc" {
  name = var.vcenter_datacenter
}

# Get Datastore info from vcenter
data "vsphere_datastore" "main-datastore" {
  name          = var.vcenter_datastore
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Get Network info from vcenter
data "vsphere_network" "vm-network" {
  name          = var.vcenter_network
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Target Resource Pool
data "vsphere_resource_pool" "target-resource-pool" {
  name          = "${var.vcenter_host}/Resources/"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.consul_template_name
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Provision a VM

resource "vsphere_virtual_machine" "vm" {
  name             = var.consul_machine_hostname
  resource_pool_id = data.vsphere_resource_pool.target-resource-pool.id
  datastore_id     = data.vsphere_datastore.main-datastore.id
  num_cpus         = data.vsphere_virtual_machine.template.num_cpus
  memory           = data.vsphere_virtual_machine.template.memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.vm-network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = data.vsphere_virtual_machine.template.disks.0.label
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = var.consul_machine_hostname
        domain    = "consul.rinn.az"
      }
      network_interface {
        ipv4_address = "10.180.12.170"
        ipv4_netmask = 24
      }
      ipv4_gateway = "10.180.12.20"
    }
  }
}

