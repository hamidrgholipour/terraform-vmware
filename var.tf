data "vsphere_datacenter" "dc" {
  name = "DC1"
}

data "vsphere_datastore" "datastore" {
  name          = "local1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM_Net_DPortGroup"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "ubuntu-20-golden"
  datacenter_id = data.vsphere_datacenter.dc.id
} 