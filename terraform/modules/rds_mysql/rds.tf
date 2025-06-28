resource "aws_db_parameter_group" "secure_mysql" {
  name   = "secure-mysql-params"
  family = "mysql8.0"

  parameter {
    name         = "require_secure_transport"
    value        = "ON"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "tls_version"
    value        = "TLSv1.2"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_instance" "rds_mysql_db" {
  identifier             = "rds-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_encrypted      = true
  kms_key_id             = "arn:aws:kms:ap-south-1:797771596047:key/2bdcf678-1a26-4106-9c31-83fdd2838a63"
  db_name                = "mydatabase"
  username               = "admin"
  password               = "your_secure_password" # Consider using Secrets Manager
  parameter_group_name   = aws_db_parameter_group.secure_mysql.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.rds_mysql_sg_id]
  db_subnet_group_name   = var.rds_mysql_db_sg
  multi_az               = false

  # Explicitly declare dependency
  depends_on = [aws_db_parameter_group.secure_mysql]

  tags = {
    Name = "mysql-db"
  }
}