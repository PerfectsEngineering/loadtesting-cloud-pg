resource "vultr_ssh_key" "runner_ssh_key" {
  name   = "loadtest-runner-ssh-key"
  ssh_key = file(var.ssh_key_file_path)
}

resource "vultr_firewall_group" "runner_firewallgroup" {
  description = "loadtest runner firewall"
}

resource "vultr_firewall_rule" "runner_firewallrule" {
  for_each = toset(["22"])
  firewall_group_id = vultr_firewall_group.runner_firewallgroup.id
  protocol = "tcp"
  ip_type = "v4"
  subnet = "0.0.0.0"
  subnet_size = 0
  port = each.value
}

resource "vultr_instance" "runner" {
  plan = "voc-g-4c-16gb-80s-amd"
  region = var.region
  os_id = 1743 // Ubuntu 22.04 LTS x64
  hostname = "runner"
  activation_email = false
  ssh_key_ids = [vultr_ssh_key.runner_ssh_key.id]
  firewall_group_id = vultr_firewall_group.runner_firewallgroup.id
}