## terraform.
<br/>

[terraform](https://www.terraform.io/), developed by hashicorp, is a infrastructure as code (IaC) tool used to provision cloud resource on multiple public cloud platforms. in this project, terraform is used to version control the google cloud platform (GCP) infrastructure necessary to run the application (including both api's and the web application itself).

## authentication.

to authenticate for terraform deployments, i recommend using [service account impersonation](https://cloud.google.com/docs/authentication/use-service-account-impersonation). service account impersonation allows you to authenticate using your GCP credentials and then act as a service account. this removes the need to manage and store an authentication key for your service account.

see the following tutorial to configure service account impersonation [link](https://cloud.google.com/blog/topics/developers-practitioners/using-google-cloud-service-account-impersonation-your-terraform-code)

note that your service account will need read/write access to the following resources:
* cloud run
* cloud cdn
* cloud firestore (cloud datastore)
* TODO

## variables.

terraform variables are initialied in the `variables.tf` file and values should be set in a file named `terraform.tfvars`. the latter file is excluded from source control. view the `variables.tf` file for a list of variables and set values as necessary in your `terraform.tfvars` file. for example:

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


## modules.

each service has its own module. the file structure of terraform configuration files mirrors the source code file structure.
