resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "load_test_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "load_test_internet_gateway"
  }
}

resource "aws_default_route_table" "vpc_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "load_test_internet_route"
  }
}

resource "aws_subnet" "database" {
  count   = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = format("10.0.%s.0/24", count.index + 1)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "load_test_subnet"
  }
}

resource "aws_security_group" "allow_runner" {
  name        = "allow_runner"
  description = "Allow runner inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "EC2 Runners"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.runner.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_subnet" "runner" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.11.0/24" # sufficiently far from database subnets
  map_public_ip_on_launch = true

  tags = {
    Name = "load_test_runner"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_network_interface" "runner" {
  subnet_id   = aws_subnet.runner.id
  private_ips = ["10.0.11.100"]
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "primary_network_interface"
  }
}
