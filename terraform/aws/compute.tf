resource "aws_key_pair" "default" {
  key_name   = "loadtest-ssh-key"
  public_key = file(var.ssh_key_file_path)
}

resource "aws_instance" "runner" {
  ami           = "ami-059ddb696446729d4" # Ubuntu 22.04
  instance_type = "m5.large" # 2vCPU, 8GB
  key_name = aws_key_pair.default.key_name

  network_interface {
    network_interface_id = aws_network_interface.runner.id
    device_index         = 0
  }

  tags = {
    Name = "LoadtestRunner"
  }
}