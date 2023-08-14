#!/bin/sh
set -e

echo "Configuring Ansible with Terraform Output"

tf="terraform -chdir=$1"

if [[ -z "$($tf output -raw compute_public_ip)" ]]; then
  echo "ERROR: No public Ip for load test runner in terraform state."
  echo "Try re-running terraform apply. Azure sometimes delays before creating IP Address"
  exit 1
fi

cat <<EOF > playbook/hosts
[servers]
$($tf output -raw compute_public_ip) ansible_user=$($tf output -raw compute_ssh_user)
EOF

cat <<EOF > playbook/vars.yml
pg_host: $($tf output db_host)
pg_port: $($tf output -raw db_port)
pg_user: $($tf output -raw db_user_name)
pg_password: $($tf output -raw db_user_password)
pg_database: loadtest
EOF

echo "Configuring Ansible Done"

if [[ "$1" == *"vultr"* ]]; then
  echo "YOU SHOULD WAIT A FEW MINUTES, BEFORE RUNNING THE ANSIBLE PLAYBOOK"
  echo "VULTR TAKES SOME MINUTES BEFORE THE MACHINE IS FULLY BOOTED"
fi