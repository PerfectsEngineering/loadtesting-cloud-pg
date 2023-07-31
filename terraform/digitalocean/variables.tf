variable "do_token" {
    sensitive = true
    type = string
}

variable "ssh_key_file_path" {
    description = <<EOF
    Path to SSH public key file that will be used to login to compute instances.
    EOF
    type = string
}

variable "region" {
    default = "lon1"
    description = "Digital ocean region to provision resources in"
    type = string
}