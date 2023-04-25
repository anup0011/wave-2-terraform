variable "instance_names"{
 type = list(string)
 default = ["windows-vm","windows-instance"]
}

variable "instance_count"{
 type = number
 default = 2
}

variable "project_id"{
 type = string
 default = "db-cicdpipeline-wave-2"
}

variable "region"{
 type = string
 default = "asia"
}

variable "roles"{
 type = list(string)
 default = ["roles/compute.instanceAdmin","rols/cloudkms.cryptoKeyDecrypter"]
}


