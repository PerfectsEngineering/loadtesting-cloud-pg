resource "vultr_ssh_key" "pg_ssh_key" {
  name   = "loadtest-ssh-key"
  ssh_key = file(var.ssh_key_file_path)
}

resource "vultr_firewall_group" "pg_firewallgroup" {
  description = "postgres database firewall"
}

resource "vultr_firewall_rule" "pg_firewallrule" {
  for_each = toset(["22", "5432", "6432", "8008", "2379", "2380"])
  firewall_group_id = vultr_firewall_group.pg_firewallgroup.id
  protocol = "tcp"
  ip_type = "v4"
  subnet = "0.0.0.0"
  subnet_size = 0
  port = each.value
}

# resource "vultr_bare_metal_server" "pg_server" {
#     plan = var.db_machine_plan
#     region = var.region
#     os_id = 542 // centos stream 9
#     hostname = "loadtest-ubuntu"
#     activation_email = false
#     ssh_key_ids = [vultr_ssh_key.pg_ssh_key.id]
# }

resource "vultr_instance" "pg_server" {
  plan = var.db_machine_plan
  region = var.region
  os_id = 542 // centos stream 9
  hostname = "loadtest-ubuntu"
  activation_email = false
  ssh_key_ids = [vultr_ssh_key.pg_ssh_key.id]
  user_data = <<EOF
      #cloud-config

      package_upgrade: true

      runcmd:
        - [ firewall-cmd, --permanent, --add-port=5432/tcp ]
        - [ firewall-cmd, --reload ]
  EOF

  firewall_group_id = vultr_firewall_group.pg_firewallgroup.id
}