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