variable "apis" {

type = list
defaults = [ "iam.googleapis.com","cloudfunctions.googleapis.com" ]

}

variable "project_id" {

type = string
defaults = "db-cicdpipeline-wave-2"

}