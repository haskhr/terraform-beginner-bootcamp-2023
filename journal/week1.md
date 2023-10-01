# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

### Set values with a .tfvars file
[Sensitive variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables)

Terraform supports setting variable values with variable definition (.tfvars) files. You can use multiple variable definition files, and many practitioners use a separate file to set sensitive or secret values.

Create a new file called secret.tfvars to assign values to the new variables.
```
secret.tfvars:

db_username = "admin"
db_password = "insecurepassword"
``````
Apply these changes using the -var-file parameter. Respond to the confirmation prompt with yes.

```
 terraform apply -var-file="secret.tfvars"
random_string.lb_id: Refreshing state... [id=2Mw]
module.vpc.aws_vpc.this[0]: Refreshing state... [id=vpc-05f973211a47fb6f4]

  # ...

   aws_db_instance.database will be updated in-place
  ~ resource "aws_db_instance" "database" {
      + domain                                = ""
      + domain_iam_role_name                  = ""
        id                                    = "terraform-20210113192204255400000004"
      + kms_key_id                            = ""
      + monitoring_role_arn                   = ""
      + name                                  = ""
       Warning: this attribute value will be marked as sensitive and will
       not display in UI output after applying this change
      ~ password                              = (sensitive value)
      + performance_insights_kms_key_id       = ""
      + replicate_source_db                   = ""
        tags                                  = {}
      + timezone                              = ""
       Warning: this attribute value will be marked as sensitive and will
       not display in UI output after applying this change
      ~ username                              = (sensitive)
         (41 unchanged attributes hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.
````

Because you flagged the new variables as sensitive, Terraform redacts their values from its output when you run a plan, apply, or destroy command. 
Notice that the password is marked sensitive value, while the username is marked sensitive. The AWS provider considers the password argument for any database instance as sensitive, whether or not you declare the variable as sensitive, and will redact it as a sensitive value. You should still declare this variable as sensitive to make sure it's redacted if you reference it in other locations than the specific password argument.

Setting values with a .tfvars file allows you to separate sensitive values from the rest of your variable values, and makes it clear to people working with your configuration which values are sensitive. However, it requires that you maintain and share the secret.tfvars file with only the **appropriate people. You must also be careful not to check .tfvars files with sensitive values into version control. For this reason, **GitHub's recommended .gitignore file for Terraform configuration is configured to ignore files matching the pattern '*.tfvars.'**


### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- [Managing Variables
](https://developer.hashicorp.com/terraform/enterprise/workspaces/variables/managing-variables)

### order of terraform variables

- [Variables](https://developer.hashicorp.com/terraform/enterprise/workspaces/variables)


## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift



[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- TODO: document this flag

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence.

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)