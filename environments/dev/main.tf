module "ecr" {
  source  = "../../modules/ecr"
  project = var.project
  env     = var.env
}

module "alb" {
  source            = "../../modules/alb"
  project           = var.project
  env               = var.env
  vpc_id            = "vpc-0778ad9a2069279fc"
  public_subnet_ids = ["subnet-0cc23dc8400d81bf3", "subnet-03328ca5b606c3a5f"]
  app_port          = var.app_port
  health_check_path = var.health_check_path
}

module "ecs" {
  source             = "../../modules/ecs"
  project            = var.project
  env                = var.env
  vpc_id             = "vpc-0778ad9a2069279fc"
  public_subnet_ids  = ["subnet-0cc23dc8400d81bf3", "subnet-03328ca5b606c3a5f"]
  alb_sg_id          = module.alb.alb_sg_id
  blue_tg_arn        = module.alb.blue_tg_arn
  http_listener_arn  = module.alb.http_listener_arn
  execution_role_arn = "arn:aws:iam::811738710312:role/ecs_fargate_taskRole"
  ecr_image_url      = "${module.ecr.repository_url}:latest"
  desired_count      = 1
}

module "codedeploy" {
  source                   = "../../modules/codedeploy"
  project                  = var.project
  env                      = var.env
  codedeploy_role_arn      = "arn:aws:iam::811738710312:role/codedeploy_role"
  ecs_cluster_name         = module.ecs.cluster_name
  ecs_service_name         = module.ecs.service_name
  http_listener_arn        = module.alb.http_listener_arn
  test_listener_arn        = module.alb.test_listener_arn
  blue_tg_name             = module.alb.blue_tg_name
  green_tg_name            = module.alb.green_tg_name
  deployment_config        = "CodeDeployDefault.ECSAllAtOnce"
  termination_wait_minutes = 5
}