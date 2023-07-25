#!/bin/sh

echo "Configuring Ansible with Terraform Output"

tf="terraform -chdir=$1"

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