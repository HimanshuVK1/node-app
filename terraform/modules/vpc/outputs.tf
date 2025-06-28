output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_id" {
  value =    [for subnet in aws_subnet.private : subnet.id]

}

output "security_group_id_allow_tls" {
  value = aws_security_group.allow_tls.id
}

output "security_group_id_alb_sg" {
  value = aws_security_group.alb-sg.id
}

output "rds_mysql_db_sg" {
  value = aws_db_subnet_group.rds_mysql_db_sg.name
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}