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

Also, you'll need to be authenticated to the various cloud providers.

**DigitalOcean**

You'll need an api token and have it exported as an environment variable named `TF_VAR_do_token`.

**Google Cloud**

The easiest approach to authenticate is using `gcloud`.
```sh
gcloud auth application-default login
```

If you don't have gcloud install it from [here](https://cloud.google.com/sdk/docs/install).

Also, if your google cloud project is new, you'll need to enable the following APIs:

```sh
gcloud services enable compute.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable servicenetworking.googleapis.com
```

**AWS**

TBD

### Setting up Resources

This uses terraform.

Run the following command to create those resources:

```sh
make tf-apply
```

Provide all the required variables or set them as TF_VAR_ prefixed environment variables (see env-sample.sh).

Type `yes` after confirming the right resources are being created.

## Running the Tests

Once the Resources have been completely setup in the particular cloud provider,
update the ansible target hosts based on the output and run the
ansible playbook with:

```sh
make ansible-run
```