benchmark-prep:
	docker run --rm -e PGPASSWORD=$$PGPASSWORD postgres:15.3 pgbench \
		-h $$PGHOST -p 5432 -U $$PGUSER \
		-i -s $${SCALE:-1000} --quiet $$PGDATABASE

benchmark:
	docker run --rm -e PGPASSWORD=$$PGPASSWORD postgres:15.3 pgbench \
		-h $$PGHOST -p 5432 -U $$PGUSER \
		--client=$${CLIENTS:-10} --jobs=$${THREADS:-4} $$PGDATABASE

override infra-path := ./terraform

override tf-path = $(infra-path)/$(provider)

provider = $(shell echo $${PROVIDER:-digitalocean})

tf = terraform -chdir=$(tf-path)

tf-init:
	terraform -chdir=$(tf-path) init

tf-plan:
	terraform -chdir=$(tf-path) plan

tf-apply: _tf-apply _setup-ansible

_tf-apply:
	terraform -chdir=$(tf-path) apply

_setup-ansible:
	./setup_ansible.sh $(tf-path)


tf-destroy:
	terraform -chdir=$(tf-path) destroy

ansible-run:
	ansible-playbook -i playbook/hosts playbook/run.yml