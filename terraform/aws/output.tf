output "db_host" {
    value = aws_db_instance.postgres.address
}

output "db_port" {
    value = aws_db_instance.postgres.port
}

output "db_user_name" {
    value = aws_db_instance.postgres.username
}

output "db_user_password" {
    value = aws_db_instance.postgres.password
    sensitive = true
}

output "compute_public_ip" {
    value = aws_instance.runner.public_ip
}