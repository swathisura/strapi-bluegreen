module "vpc" {
  source               = "../../modules/vpc"
  project              = var.project
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "iam" {
  source  = "../../modules/iam"
  project = var.project
  env     = var.env
}

module "ecr" {
  source  = "../../modules/ecr"
  project = var.project
  env     = var.env
}

module "cloudwatch" {
  source         = "../../modules/cloudwatch"
  project        = var.project
  env            = var.env
}

module "alb" {
  source            = "../../modules/alb"
  project           = var.project
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  app_port          = var.app_port
  health_check_path = var.health_check_path
}

module "ecs" {
  source             = "../../modules/ecs"
  project            = var.project
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  alb_sg_id          = module.alb.alb_sg_id
  blue_tg_arn        = module.alb.blue_tg_arn
  http_listener_arn  = module.alb.http_listener_arn
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecr_image_url      = "${module.ecr.repository_url}:latest"
  log_group_name     = module.cloudwatch.log_group_name
  aws_region         = var.aws_region
  desired_count      = 2
}

module "codedeploy" {
  source                   = "../../modules/codedeploy"
  project                  = var.project
  env                      = var.env
  codedeploy_role_arn      = module.iam.codedeploy_role_arn
  ecs_cluster_name         = module.ecs.cluster_name
  ecs_service_name         = module.ecs.service_name
  http_listener_arn        = module.alb.http_listener_arn
  test_listener_arn        = module.alb.test_listener_arn
  blue_tg_name             = module.alb.blue_tg_name
  green_tg_name            = module.alb.green_tg_name
  deployment_config        = "CodeDeployDefault.ECSCanary10Percent5Minutes"
  termination_wait_minutes = 10
}

module "rds" {
  source             = "../../modules/rds"
  project            = var.project
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_sg_id          = module.ecs.ecs_sg_id
  db_instance_class  = "db.t3.small"
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
}