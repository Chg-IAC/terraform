##########TAG Park8s Master ###########

resource "vsphere_tag_category" "Master" {
  name        = "${var.Master_attrubute_name}"
  description = "Node Type Master"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine"
  ]
}

resource "vsphere_tag" "PARK8SMP_TAG" {
  name        = "${var.K8S_tag}"
  category_id = "${vsphere_tag_category.Master.id}"
  description = "Master Kubernetes Nodes"
}
##########TAG Park8s Worker ###########

resource "vsphere_tag_category" "Worker" {
  name        = "${var.Worker_attrubute_name}"
  description = "Node Type Worker"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine"
  ]
}

resource "vsphere_tag" "PARK8SWP_TAG" {
  name        = "${var.K8S_tag}"
  category_id = "${vsphere_tag_category.Worker.id}"
  description = "Worker Kubernetes Nodes"
}


##########TAG PARLBC Master ###########

resource "vsphere_tag" "PARLBCWP_TAG" {
  name        = "${var.LBC_tag}"
  category_id = "${vsphere_tag_category.Worker.id}"
  description = "Worker HA Proxy Nodes"
}

##########TAG PARLBC Worker ###########

resource "vsphere_tag" "PARLBCMP_TAG" {
  name        = "${var.LBC_tag}"
  category_id = "${vsphere_tag_category.Master.id}"
  description = "Master HA Proxy Nodes"
}