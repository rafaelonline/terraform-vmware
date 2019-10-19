#Parametros de conexao no vcenter
provider "vsphere" {
  user                 = "${var.vsphere_user}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

# Obtendo os dados do Datacenter
data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_dc_name}"
}

# Obtendo os dados do Cluster
data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Obtendo dados datastore
data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "${var.vsphere_dscluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Obtendo dados rede
data "vsphere_network" "network" {
  name          = "${var.vsphere_portgroup_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
# Datacenter onde localiza-se o template
data "vsphere_datacenter" "datacenter_templates" {
  name = "${var.datacenter_templates_name}"
}
# Obtendo as informações do template
data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template_name}"
  datacenter_id = "${data.vsphere_datacenter.datacenter_templates.id}"
}