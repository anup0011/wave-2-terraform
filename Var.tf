variable "vm_count"
{
  default =2
  }

variable "vm_names"
{
  type=list(string)
  default =["windows_vm1","windows_vm2"]
  }
