variable "apis" {

type = list
default = [ "iam.googleapis.com","cloudfunctions.googleapis.com" ]

}

variable "project_id" {

type = string
default = "db-cicdpipeline-wave-2"

}