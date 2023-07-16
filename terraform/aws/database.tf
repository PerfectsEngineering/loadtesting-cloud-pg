resource "random_id" "user_password" {
  byte_length = 8
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres_subnet"
  subnet_ids = [for database in aws_subnet.database : database.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 10
  db_name              = "loadtest"
  engine               = "postgres"
  engine_version       = "15.2"
  instance_class       = "db.t4g.xlarge" # 4 CPU, 16GB RAM
  identifier_prefix    = "loadtest-db"
  
  username             = "loadtest_user"
  password             = random_id.user_password.hex

  db_subnet_group_name = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [aws_security_group.allow_runner.id]

  apply_immediately    = true
  skip_final_snapshot  = true
}
