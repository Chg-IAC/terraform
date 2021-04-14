################################################
################################################
#######Connection du script au Vsphere##########
################################################
################################################
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
################################################
################################################
######Récupere les données du datacenter########
################################################
################################################
data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_resource_pool" "pool" {
  name          = var.rp
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_storage_policy" "policy" {
  name = var.policy
}
data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
################################################
################################################
###########Création de la ressource#############
################################################
################################################
resource "vsphere_virtual_machine" "vm" {
  for_each = var.auto
  name             = each.key
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  
  num_cpus = var.cpus
  memory   = var.memory
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
    adapter_type = var.adapter_interface
  }

  disk {
    storage_policy_id = "${data.vsphere_storage_policy.policy.id}"
    label = var.disk_type
    size  = var.disk_size
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
      timeout = "20"

      linux_options {
        host_name = each.key
        domain    = var.vm_domain
      }
      network_interface {
        ipv4_address = var.auto[each.key]
        ipv4_netmask = var.vm_netmask
      }
      ipv4_gateway    = var.vm_gateway
      dns_server_list = [var.vm_dns]
    }
  }
}

