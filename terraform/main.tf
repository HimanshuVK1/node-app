module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source                    = "./modules/ec2"
  vpc_id                    = module.vpc.vpc_id
  security_group_id         = module.vpc.security_group_id_allow_tls
  public_subnet_ids         = module.vpc.public_subnet_ids
  target_group_name         = "loadbalancer-target-group"
  iam_instance_profile_name = module.iam.ssm_profile_name
  # alb_sg_id                 = module.vpc.security_group_id_alb_sg
  security_group_id_alb_sg  = module.vpc.security_group_id_alb_sg
  acm_certificate_arn       = "arn:aws:acm:ap-south-1:797771596047:certificate/80dda8b0-9085-44ce-b2c3-304561889b03"
}

module "route53" {
  source = "./modules/route53"
  host_zone_id = "Z00653713B8CBDMCEGAGS"
  elb_dns_name = module.ec2.elb_dns_name
  records_name = "node.himanshuvk.xyz"
}



module "rds_mysql" {
  source = "./modules/rds_mysql"
  rds_mysql_db_sg = module.vpc.rds_mysql_db_sg
  rds_mysql_sg_id = module.vpc.rds_mysql_sg_id
}

module "ecr" {
  source = "./modules/ecr"
}

