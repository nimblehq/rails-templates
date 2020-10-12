module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.18.0"

  identifier = var.namespace

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_type
  allocated_storage = var.allocated_storage


  option_group_name    = aws_db_option_group.main.name
  parameter_group_name = aws_db_parameter_group.main.name

  name     = var.name
  username = var.username
  password = var.password
  port     = var.port

  vpc_security_group_ids = [aws_security_group.rds.id]
  subnet_ids             = var.subnet_ids
  multi_az               = var.multi_az

  maintenance_window   = var.maintenance_window
  backup_window        = var.backup_window
  major_engine_version = "11"
  family               = "postgres11"
}

resource "aws_security_group" "rds" {
  name   = "${var.namespace}-rds"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rds_ingress_app_instance" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = var.ingress_source_security_group_id
}

resource "aws_security_group_rule" "rds_egress_app_instance" {
  type                     = "egress"
  security_group_id        = aws_security_group.rds.id
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = var.egress_source_security_group_id
}

resource "aws_db_parameter_group" "main" {
  name        = "${var.namespace}-pg"
  description = "${var.namespace} DB Parameter Group"
  family      = "postgres11"
}

resource "aws_db_option_group" "main" {
  name_prefix          = var.namespace
  major_engine_version = "11"
  engine_name          = "postgres"
}
