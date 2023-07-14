# Testing Cloud Postgres Performance

This repository contains the code for setting up various cloud resources across
different cloud providers (DigitalOcean, AWS, GCP) to run postgres tests
and compare how much difference in performances there are.

## Result of Load Tests

The results of running these test are published as a blog post here: <TBD>


## Running the tests for yourself

### Requirements

You need to have the following tools installed on your local machine:

- terraform
- ansible
- make


### Setting up Resources

This uses terraform.

Run the following command to create those resources:

```
make tf-apply
```

Provide all the required variables or set them as TF_VAR_ prefixed environment variables (see env-sample.sh).

Type `yes` after confirming the right resources are being created.

## Running the Tests

Once the Resources have been completely setup in the particular cloud provider,
update the ansible target hosts based on the output and run the
ansible playbook with:

```
make ansible-run
```