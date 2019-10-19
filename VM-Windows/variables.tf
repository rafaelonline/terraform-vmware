variable "vsphere_user" {
  default = "user_vcenter"
}

variable "vsphere_password" {
  default = "pass_vcenter"
}

variable "vsphere_server" {
  default = "vcenter.seudominio.com"
}

variable "vsphere_compute_cluster" {
  default = "seu cluster"
}

variable "vsphere_dscluster" {
  default = "datastore"
}

#variable "vsphere_folder" {
#  default = "folder name"
#}

variable "vsphere_dc_name" {
  default = "seu datacenter"
}

variable "vsphere_portgroup_name" {
  default = "portgroup name"
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

variable "vsphere_template_name" {
  default = "nome do template"
}

variable "datacenter_templates_name" {
  default = "data center onde esta o template"
}

variable "winadmin_password" {
  default = "pass_user_local"
}

variable "VM_IP" {
  default = "IP"
}

variable "netmask" {
  default = "mask"
}

variable "dns_server" {
  default = "dns ip"
}

variable "def_gw" {
  default = "gateway ip"
}

variable "domain_name" {
  default = "seudominio.com"
}

variable "organization_name" {
  default = "organization_name"
}

variable "product_key" {
  default = "chave de ativacao do Windows"
}

variable "time_zone" {
  default = "065" #Sao Paulo TZ
}

variable "domain_user" {
  default = "user domain"
}

variable "domain_password" {
  default = "pass domain"
}