variable "vm_names"{
 type = list(string)
 default = ["windows-vm1","windows-vm2"]
}

variable "vm_count"{
 type = number
 default = 2
}
