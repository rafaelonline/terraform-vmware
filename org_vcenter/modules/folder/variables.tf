variable "vsphere_server" {
  default = "<Endereco do seu vcenter>"
}

variable "vsphere_user" {
  default = "<user vcenter>"
}

variable "vsphere_password" {
  default = "<pass vcenter>"
}

variable "vsphere_dc_name" {
  default = "<Nome Datacenter>"
}

variable "parent_folder" {}

variable "child_folder" {
  type    = "list"
  default = ["producao", "desenvolvimento", "homologacao"]
}