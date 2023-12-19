## terraform.
<br/>

[terraform](https://www.terraform.io/), developed by hashicorp, is a infrastructure as code (IaC) tool used to provision cloud resource on multiple public cloud platforms. in this project, terraform is used to version control the google cloud platform infrastructure necessary to run the application (including both api's and the web application itself).

## variables.

terraform variables are specified in the `terraform.tfvars` file. copy the `terraform.tfvars.default` file to a file named `terraform.tfvars` to configure variables for the project.

## modules.

each