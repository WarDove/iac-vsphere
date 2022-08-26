# # Create the DC
# resource "vsphere_datacenter" "azin-sphere-dc" {
#   name = var.dc_name
# }

# # Add underlying hosts into DC
# resource "vsphere_host" "esx-01" {
#   hostname   = var.esx-01_server
#   username   = var.esx-01_user
#   password   = var.esx-01_password
#   datacenter = vsphere_datacenter.azin-sphere-dc.moid

#   lifecycle {
#     ignore_changes = [
#       cluster
#     ]
#   }
# }

data "vsphere_datacenter" "main-dc" {
  name = "azin-sphere-dc"
}

# Get Datastore info from vcenter
data "vsphere_datastore" "main-datastore" {
  name          = "main-datastore"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Get Network info from vcenter
data "vsphere_network" "vm-network" {
  name          = "VLAN3513"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Target Resource Pool
data "vsphere_resource_pool" "target-resource-pool" {
  name          = "${var.esx-01_server}/Resources/"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "linux-ubuntu-desktop-amd64-22-04-lts"
  datacenter_id = data.vsphere_datacenter.main-dc.id
}

# Provision a VM

resource "vsphere_virtual_machine" "vm" {
  name             = "hello-world"
  resource_pool_id = data.vsphere_resource_pool.target-resource-pool.id
  datastore_id     = data.vsphere_datastore.main-datastore.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.vm-network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "hello-world"
        domain    = "example.com"
      }
      network_interface {
        ipv4_address = "10.180.12.170"
        ipv4_netmask = 24
      }
      ipv4_gateway = "10.180.12.20"
    }
  }
}

