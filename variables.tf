variable "project" {
  type    = string
  default = "db-cicdpipeline-wave-2"
}
variable "machine_type" {
  type    = string
  default = "e2-medium"
}
variable "image_linux" {
  type    = string
  default = "debian-cloud/debian-11"
}
variable "image_windows" {
  type    = string
  default = "windows-server-2022-datacenter"
}
variable "vm_count" {
  default = 2
}
variable "roles"{
 type = list(string)
 default = ["roles/compute.instanceAdmin","roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}
