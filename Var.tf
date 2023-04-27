variable "vm_names"{
 type = list(string)
 default = ["windows-vm1","windows-vm2"]
}

variable "vm_count"{
 type = number
 default = 2
}
variable "roles"{
 type = list(string)
 default = [
  "roles/compute.instanceAdmin",
 "roles/cloudkms.cryptoKeyEncrypterDecrypter",
 "roles/iam.serviceAccountAdmin",
 "roles/composer.admin"
 ]
}
