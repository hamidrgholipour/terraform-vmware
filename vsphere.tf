# Set vm parameters
resource "vsphere_virtual_machine" "demo" {
  name             = "vm-one"
  num_cpus         = 2
  memory           = 4096
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  # Set network parameters
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  # Use a predefined vmware template as main disk
  disk {
    label = "vm-one.vmdk"
    size = "30"
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "vm-one"
        domain    = "vm-one.homelab.local"
      }

      network_interface {
        ipv4_address    = "192.168.0.240"
        ipv4_netmask    = 24
        dns_server_list = ["192.168.0.120", "192.168.0.121"]
      }

      ipv4_gateway = "192.168.0.1"
    }
  }

  # Execute script on remote vm after this creation
  provisioner "remote-exec" {
    script = "scripts/example-script.sh"
    connection {
      type     = "ssh"
      user     = "root"
      password = "VMware1!"
      host     = vsphere_virtual_machine.demo.default_ip_address 
    }
  }
}