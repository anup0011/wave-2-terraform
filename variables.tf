variable "project" {
  type    = string
  default = "db-cicdpipeline-wave-2"
}
variable "instance_names"{
 type = list(string)
 default = ["windows-vm","windows-instance"]
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
  default = "windows-cloud/windows-2022"
}
variable "vm_count" {
  default = 2
}
variable "roles"{
 type = list(string)
 default = [
 "roles/compute.osLogin",
 "roles/iam.serviceAccountUser"
 ]
}
variable "test_subnet" {
  default = "project/db-cicdpipeline-wave-2/region/asia-south2/wave2-as2"
}
