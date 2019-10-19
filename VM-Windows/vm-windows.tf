resource "vsphere_virtual_machine" "vm" {
  name                 = "${var.VM_name}"
  #folder               = "${var.vsphere_folder}"
  resource_pool_id     = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_cluster_id = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

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
    size             = 120
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    timeout       = 120

    customize {
      timeout = 0
      windows_options {
        computer_name         = "${var.VM_name}"
        admin_password        = "${var.winadmin_password}"
        join_domain           = "${var.domain_name}"
        domain_admin_user     = "${var.domain_user}"
        domain_admin_password = "${var.domain_password}"
        time_zone             = "${var.time_zone}"
        organization_name     = "${var.organization_name}"
        product_key           = "${var.product_key}"
        auto_logon            = false
        auto_logon_count      = 1

        # Run these commands after autologon. Configure WinRM access and disable windows firewall.
        run_once_command_list = [
          "winrm quickconfig -force",
          "winrm set winrm/config @{MaxEnvelopeSizekb=\"100000\"}",
          "winrm set winrm/config/Service @{AllowUnencrypted=\"true\"}",
          "winrm set winrm/config/Service/Auth @{Basic=\"true\"}",
          "netsh advfirewall set allprofiles state off",
        ]
      }

      network_interface {
        ipv4_address    = "${var.VM_IP}"
        ipv4_netmask    = "${var.netmask}"
        dns_server_list = "${var.dns_server}"
      }
      ipv4_gateway = "${var.def_gw}"
    }
  }
} 