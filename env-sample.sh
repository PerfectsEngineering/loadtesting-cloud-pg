#!/bin/sh

export PGUSER=postgres
export PGHOST=host.docker.internal
export PGPASSWORD=secretpassword
export PGDATABASE=loadtest

export TF_VAR_do_token=dop_v1_xxx
export TF_VAR_gcp_project_id=loadtest-gcp-project
export TF_VAR_ssh_key_file_path=/Users/profile/.ssh/id_ed25519.pub
export TF_VAR_heroku_api_key=uuid-api-key

export AWS_ACCESS_KEY_ID="access key id"
export AWS_SECRET_ACCESS_KEY="secret access key"
