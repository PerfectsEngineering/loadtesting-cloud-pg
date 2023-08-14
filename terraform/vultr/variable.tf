variable "vultr_api_key" {
  description = "API Key exported from Vultr"
  type = string
}

variable "ssh_key_file_path" {
    description = <<EOF
    Path to SSH public key file that will be used to login to compute instances.
    EOF
    type = string
}

variable "region" {
  # default = "lhr"
  default = "lax"
  type = string
}

variable "db_machine_plan" {
    description = <<EOF
    The plan of the machine to use for the database.
    EOF
    type = string
    # default = "voc-g-4c-16gb-80s-amd"
    default = "vbm-4c-32gb"
    # default = "vbm-6c-32gb"
}