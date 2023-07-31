variable "ssh_key_file_path" {
    description = <<EOF
    Path to SSH public key file that will be used to login to compute instances.
    EOF
    type = string
}

variable "region" {
  default = "eu-west-2"
  type = string
}