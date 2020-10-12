variable "namespace" {}

variable "engine" {
  default = "postgres"
}

variable "engine_version" {
  default = "11.4"
}

variable "instance_type" {
  default = "db.t3.small"
}

variable "allocated_storage" {
  default = 20
}

variable "max_allocated_storage" {
  default = 100
}

variable "storage_type" {
  default = "gp2"
}


variable "multi_az" {
  default = true
}

variable "port" {
  default = "5432"
}

variable "username" {
  default = ""
}

variable "password" {
  default = ""
}

variable "name" {}

variable "parameter_group_name" {
  default = "default.postgres12"
}

variable "ingress_source_security_group_id" {}
variable "egress_source_security_group_id" {}
variable "vpc_id" {}

variable "subnet_ids" {
  type = list
}

variable "backup_window" {
  default = "21:00-22:00"
}

variable "maintenance_window" {
  default = "sun:19:00-sun:20:00"
}

variable "parameter_group_family" {
  default = "postgres11"
}
