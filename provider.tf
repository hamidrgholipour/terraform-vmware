provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "*"
  vsphere_server = "vcenter.hamid.local"

  allow_unverified_ssl = true
}