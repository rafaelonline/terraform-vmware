resource "vsphere_folder" "parent" {
  path          = "${var.parent_folder}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "child" {
  count = "${length(var.child_folder)}"
  path          = "${vsphere_folder.parent.path}/${element(var.child_folder,count.index)}"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}