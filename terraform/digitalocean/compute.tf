resource "digitalocean_ssh_key" "default" {
  name       = "Loadtest SSH Key"
  public_key = file(var.ssh_key_file_path)
}

resource "digitalocean_droplet" "runner" {
  name   = "loadtest-runner"
  size   = "s-2vcpu-4gb"
  image  = "ubuntu-22-04-x64"
  region = var.region
  vpc_uuid = digitalocean_vpc.vpc.id
  ssh_keys = [ digitalocean_ssh_key.default.fingerprint ]
}