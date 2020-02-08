variable "env" {}

variable "aws" {
  type    = any
  default = {}
}

variable "dns" {
  type    = any
  default = {}
}

variable "custom_tags" {
  type    = map
  default = {}
}

variable "records" {
  type        = map
  default     = {}
  description = "Map of records to add to the dns zone"
}
