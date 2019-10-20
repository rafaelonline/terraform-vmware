variable "vsphere_server" {
  default = "vcenter.seudominio.com"
}

variable "vsphere_user" {
  default = "user_vcenter"
}

variable "vsphere_password" {
  default = "pass_vcenter"
}

variable "vsphere_compute_cluster" {
  default = "cluster_vcenter"
}

variable "vsphere_dscluster" {
  default = "datastore"
}
variable "vsphere_dc_name" {
  default = "datacenter_name"
}
variable "parent_folder" {
  default = "pasta_pai"
}

variable "child_folder" {
  default = "pasta_filho"
}

variable "VM_cpu_num" {
  default = "numero de vcpu"
}

variable "VM_mem" {
  default = "numero de memoria"
}

variable "VM_name" {
  default = "nome da vm"
}

variable "vsphere_portgroup_name" {}

variable "VM_IP" {
  default = "IP"
}

variable "netmask" {
  default = "mask"
}

variable "def_gw" {
  default = "gateway ip"
}

variable "dns_server" {
  default = "dns ip"
}

variable "domain_name" {
  default = "seudominio.com"
}

variable "vsphere_template_name" {
  default = "nome do template"
}

variable "datacenter_templates_name" {
  default = "datacenter onde esta o template"
}