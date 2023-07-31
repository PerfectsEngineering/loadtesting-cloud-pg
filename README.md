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

The straightforward approach to authenticate is using `gcloud`.
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

See the various ways you can authenticate AWS [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
The straightforward way will be to create an Access Token (ID and Secret) for a user with 
enough permissions to provision EC2 and RDS instances and export them as environment variables:

```sh
export AWS_ACCESS_KEY_ID="<<access_key_id>>"
export AWS_SECRET_ACCESS_KEY="<<access_key_secret>>"
```

### Setting up Resources

This uses terraform to provision the respective cloud providers resources.
Depending on which cloud provider you want to test, export a `PROVIDER` environment variable first.
The possible values are `digitalocean`(default), `gcp` & `aws`. For example:

```sh
export PROVIDER=gcp
```

<details>
  <summary>Optional Init Instructions</summary>

  If this is your first time running any terraform command for your provider, then you need to run:
  ```sh
  make tf-init
  ```
</details>

Run the following command to create those resources:

```sh
make tf-apply
```

Provide all the required variables or set them as TF_VAR_ prefixed environment variables (see env-sample.sh).

Type `yes` at the prompt after confirming that the right resources will be created.

Once the Resources have been completely set up in the particular cloud provider. Proceed to the next step.
### Running the Tests

The `tf-apply` command would have also updated the ansible configuration. Look in `playbook/hosts` and `playbook/vars.yml` to be sure.

Next, run the Ansible playbook with:

```sh
make ansible-run
```

If run successfully, the output of the pgbench tests will be in a csv file name `result/<provider>.csv`.

### Cleaning up Resources

After the process has finished running and result gotten, destroy the provisioned cloud resources with:

```sh
make tf-destroy
```