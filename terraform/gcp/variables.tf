variable "ssh_key_file_path" {
    description = <<EOF
    Path to SSH public key file that will be used to login to compute instances.
    EOF
    type = string
}

variable "gcp_project_id" {
    description = "GCP project ID to provision resources in."
    type = string
}

variable "region" {
    default = "europe-west2"
    description = "Digital ocean region to provision resources in"
    type = string
}

variable "compute_zone" {
    default = "europe-west2-a"
    description = "Zone to create compute servers that will run the test"
    type = string
}