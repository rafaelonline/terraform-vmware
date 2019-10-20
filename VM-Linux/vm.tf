resource "vsphere_folder" "parent" {
  path          = "${var.parent_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "child" {
  path          = "${vsphere_folder.parent.path}/${var.child_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name                 = "${var.VM_name}"
  resource_pool_id     = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"
  folder = "${vsphere_folder.child.path}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }
  num_cpus  = "${var.VM_cpu_num}"
  memory    = "${var.VM_mem}"
  guest_id  = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  disk {
    unit_number      = 0
    label            = "SO"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  disk {
    unit_number      = 1
    label            = "Dados"
    size             = 80
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  wait_for_guest_net_timeout = 0

  wait_for_guest_net_routable = false

  force_power_off             = true

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    timeout       = 120

    customize {
      timeout = 0
      linux_options {
        host_name = "${var.VM_name}"
        domain    = "${var.domain_name}"
      }

      network_interface {
        ipv4_address = "${var.VM_IP}"
        ipv4_netmask = "${var.netmask}"
      }

      dns_server_list = "${var.dns_server}"
      dns_suffix_list = "${var.domain_name}"
      ipv4_gateway = "${var.def_gw}"
    }
  } 
} 