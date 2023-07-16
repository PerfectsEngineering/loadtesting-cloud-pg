variable "ssh_key_file_path" {
    description = <<EOF
    Path to SSH public key file that will be used to login to compute instances.
    EOF
}

variable "region" {
  default = "eu-west-2"
}