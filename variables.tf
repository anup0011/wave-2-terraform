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

variable "iam_members" {
  type = list(string)
  default = [ 
    "user:koshike.sushmitha@tcs.com",
    "user:kushal.malla@tcs.com",
    "user:neeraja.balireddy@tcs.com",
    "user:ajaykumar.shah@tcs.com",
    "user:apanya.chauhan1@tcs.com",
    "user:keerthivashan.kc@tcs.com",
    "user:manushri.m@tcs.com",
    "user:meetu.singh@tcs.com",
    "user:nisha.shashi@tcs.com",
    "user:pavan.gowda@tcs.com",
    "user:prabin.mohanty@tcs.com",
    "user:sahithi.narla@tcs.com",
    "user:sitaramachakravarthy.peruvel@tcs.com",
    "user:srisahithi.banda@tcs.com",
    "user:suhasini.dussa@tcs.com"
   ]
}
variable "composer_region" {
  type = string
  default = "asia-south1"
}
