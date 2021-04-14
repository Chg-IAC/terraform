###############VCENTER####################
variable "vsphere_user" {
    description ="user"
    type = string
    default ="administrator@vsphere.local"
}
variable "vsphere_password" {
    description ="vsphere_password"
    type = string
    default ="Espoir123."
}
variable "vsphere_server" {
    description ="vsphere_server"
    type = string
    default ="10.0.2.1"
}
variable "datacenter" {
  default = "DC-Livestreaming_Prod"
}
variable "datastore" {
  default = "vsanDatastore"
}
variable "cluster" {
  default = "vSan-Livestreaming_Prod"
}
variable "rp" {
  default = "RP-Livestreaming-Prod"
}
variable "policy" {
  default = "vSAN Default Storage Policy"
}
variable "network" {
  default = "pG-VM-LAN-Livestreaming"
}
variable "adapter_interface" {
  default = "e1000"
}
################Ressource_VM##################
variable "template_name" {
  default = "ubuntu20.04_template"
}
variable "cpus" {
  default = "4"
}
variable "memory" {
  default = "4096"
}
variable "disk_type" {
  default = "disk0"
}
variable "disk_size" {
  default = "30"
}

variable "vm_dns" {
  default = "10.0.2.2"
}
variable "vm_gateway" {
  default = "10.0.2.254"
}
variable "vm_domain" {
  default = "livestreaming.local"
}
variable "vm_netmask" {
  default = "24"
}
variable "auto" {
    type = map
    default = {
	"PARLBC001MP" = "10.0.2.50"
        "PARLBC001WP" = "10.0.2.51"
        "PARK8S001MP" = "10.0.2.52"
        "PARK8S002MP" = "10.0.2.53"
        "PARK8S001WP" = "10.0.2.54"
        "PARK8S002WP" = "10.0.2.55"
        "PARK8S003WP" = "10.0.2.56"
    }
}
#####################################################################
