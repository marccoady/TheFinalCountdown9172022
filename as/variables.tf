# --- as/variables.tf

variable "webserver_type" {
  type    = string
  default = "t3.micro"
}

variable "fc_pb_sg" {}
#variable "pt_sg" {}
#variable "pt_sn" {}
variable "fc_pb_sn" {}
variable "key" {}
#variable "alb_tg" {}