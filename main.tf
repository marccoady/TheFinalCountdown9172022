# ---- root/main.tf

module "netsec" {
  source   = "./netsec"
  vpc_cidr = "10.0.0.0/16"
  ext_ip   = "0.0.0.0/0"
  pb_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "as" {
  source = "./as"
  fc_pb_sg  = module.netsec.fc_pb_sg
  fc_pb_sn  = module.netsec.fc_pb_sn
  key    = "TTPKey"
  #pt_sg  = module.netsec.pt_sg
  #pt_sn  = module.netsec.pt_sn
  #alb_tg = module.lb.alb_tg
}


