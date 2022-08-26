# Create the DC
resource "vsphere_datacenter" "azin-sphere-dc" {
  name = var.dc_name
}

# Add underlying hosts into DC
resource "vsphere_host" "esx-01" {
  hostname   = var.esx-01_server
  username   = var.esx-01_user
  password   = var.esx-01_password
  datacenter = vsphere_datacenter.azin-sphere-dc.moid

  lifecycle {
    ignore_changes = [
      cluster
    ]
  }

}

# # Add Compute Cluster
# resource "vsphere_compute_cluster" "azin-sphere-cc" {
#   name            = "azin-sphere-compute-cluster"
#   datacenter_id   = vsphere_datacenter.azin-sphere-dc.moid
#   host_system_ids = [vsphere_host.esx-01.id]

#   drs_enabled = false
#   ha_enabled  = false
# }

# # Add Resource Pool if DRS & HA Enabled 
#  resource "vsphere_resource_pool" "azin-sphere-rp" {
#    name                    = "azin-sphere-rp"
#    parent_resource_pool_id = vsphere_compute_cluster.azin-sphere-cc.resource_pool_id
#  }


# Get Datastore info from vcenter
data "vsphere_datastore" "main-datastore" {
  name          = "main-datastore"
  datacenter_id = vsphere_datacenter.azin-sphere-dc.moid
  depends_on = [
    vsphere_host.esx-01
  ]
}

# Get Network info from vcenter
data "vsphere_network" "vm-network" {
  name          = "VLAN3513"
  datacenter_id = vsphere_datacenter.azin-sphere-dc.moid
  depends_on = [
    vsphere_host.esx-01
  ]
}

# Target Resource Pool
data "vsphere_resource_pool" "target-resource-pool" {
  name          = "${var.esx-01_server}/Resources/"
  datacenter_id = vsphere_datacenter.azin-sphere-dc.moid
  depends_on = [
    vsphere_host.esx-01
  ]
}

data "vsphere_virtual_machine" "template" {
  name          = "linux-ubuntu-desktop-amd64-22-04-lts"
  datacenter_id = vsphere_datacenter.azin-sphere-dc.moid
  depends_on = [
    vsphere_host.esx-01
  ]
}

# HOLY MOLY

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

# # Create VM
# resource "vsphere_virtual_machine" "test" {
#   name             = "test"
#   resource_pool_id = data.vsphere_resource_pool.target-resource-pool.id 
#   datastore_id     = data.vsphere_datastore.main-datastore.id
#   num_cpus         = 1
#   memory           = 1024
#   guest_id         = "centos7_64Guest"
#   network_interface {
#     network_id = data.vsphere_network.vm-network.id
#   }
#   disk {
#     label = "disk0"
#     size  = 20
#   }
# }