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