## infrastructure
<br/>

[terraform](https://www.terraform.io/), developed by hashicorp, is a infrastructure as code (IaC) tool used to provision cloud resource on multiple public cloud platforms. in this project, terraform is used to version control the google cloud platform (GCP) infrastructure necessary to run the application (including both api's and the web application itself).

## authentication

to authenticate for terraform deployments, i recommend using [service account impersonation](https://cloud.google.com/docs/authentication/use-service-account-impersonation). service account impersonation allows you to authenticate using your GCP credentials and then act as a service account. this removes the need to manage and store an authentication service account key for your service account (distribution of a service account key can pose security risks).

see the following tutorial to configure service account impersonation [link](https://cloud.google.com/blog/topics/developers-practitioners/using-google-cloud-service-account-impersonation-your-terraform-code). before you can follow through with this tutorial, ensure that the [google cloud sdk](https://cloud.google.com/sdk/docs/install) is installed, and your user account is logged in using:

```
gcloud init
```

and

```
gcloud auth application-default login
```


note that your service account will need read/write access to the following resources:
* cloud run
* cloud functions
* cloud firestore (cloud datastore)


## variables

terraform variables are declared in the `variables.tf` file(s) and values should be set in a file named `terraform.tfvars`. the latter file is excluded from source control. view the `variables.tf` file for a list of variables and set values as necessary in your `terraform.tfvars` file. for example:

in `variables.tf`
```
variable gcp_project_id {
    description = "Google Cloud Project ID"
    type        = "string"
}
```

in `terraform.tfvars`
```
gcp_project_id = "some_project_name"
```

_note_: terraform variables cannot be used when configuring the backend for remote state file management. so, if you intend to use a remote backend, you must update the `backend.tf` file with the appropriate cloud storage bucket name.

## modules

modules are used to separate infrastructure into related services. each module has a group of resources necessary to deploy a particular service.
