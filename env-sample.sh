#!/bin/sh

export PGUSER=postgres
export PGHOST=host.docker.internal
export PGPASSWORD=secretpassword
export PGDATABASE=loadtest
export TF_VAR_do_token=dop_v1_xxx
