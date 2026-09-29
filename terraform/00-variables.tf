#Some variables 
variable "key_name" {
  type    = string
  default = "Please export an environment variable TF_VAR_key_name with the name of the public key on your cumulus"
}


variable "identity_file" {
  type    = string
  default = "Please export an environment variable TF_VAR_identity_file with the path to your key for ansible machine (path of the .pem file)."
}  

variable "webapp_port" {
  type    = number
  default = 8080 
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "flavor_name" {
  type    = string
  default = "c1-r1-d10"
}


variable "subnetwork_cidr" {
  type    = string
  default = "192.168.3.0/24"
}

variable "webapp_image_name" {
  type    = string
  default = "Ubuntu server 24.04.3 autoupgrade"
}

variable "database_image_name" {
  type    = string
  default = "Ubuntu server 24.04.3 autoupgrade"
}

variable "external_network_used" {
  type    = string
  default = "campus" 
}

variable "availability_zone" {
  type    = string
  default = "Education"
}



variable "ansible_files_relative_path" {
  type    = string
  default =  "../ansible/"
}