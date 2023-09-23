# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mag:

This Project is going utilize Semantic Versioning for its tagging.
[semver.org](https://semver.org/)

The General Format 

 **MAJOR.MINOR.PATCH** , eg.  `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## [Installation of Terrafrom CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration with Terraform CLI changes
The Terraform installation instruction has been changed due to gpg keyring changes . So we need to refer to the latest install CLI instruction via terraform documention and change the script for install 

### Consideration for Linux Distribution 
this project is built against Ubuntu
please chech your linux distribution and make necessary changes  
[How to check your Linux distribution ](https://www.howtoforge.com/how_to_find_out_about_your_linux_distribution) 

Example of checking Linux Distrubtron :

```sh
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
``````
### Refractoing into Bash script
while fixing the Terraform CLI keyring depreciation issue we notice that bash scripts were considerable amount more code . so we decided to create a bash script to install Terraform CLI.

the bash script is located her : [./bin/install_terraform_cli](./bin/install_terrafrom_cli)

- this will keep Gitpod task file[ .gitpod.yml ](.gitpod.yml) tidy.
- this will allow us to easy debug and execute manuall Terraform CLI Install 
- this will allow better portability for other projects that need to install terraform CLI

#### [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) 
A Shebang (pronounced sha-bang) tells the bash scripts what program that will interpret the script. eg   ` #!/usr/bin/ `

ChatGPT recommended to use this format . `#!/usr/bin/env bash`
- for portability for different Linux Distribution 
- will search the user's  PATH for bash executables

#### Execute Consideration
when exceuting the bash script we can use `./` shorthand notation to execute bash scripts

eg. `./bin/install_terraform_cli`

if we are using the script in .gitpod.yml ,we need to point the script to a program to interpret it. 

eg. `source ./bin/install_terraform_cli`

#### [Linux permission consideration](https://en.wikipedia.org/wiki/Chmod) 

In order to make our script executable ,we  need to change the file permission for the fix to be executable at the user mode .
```sh
$ chmod u+x ./bin/install_terraform_cli 
```
alternatrively 

```sh
$ chmod 744 ./bin/install_terraform_cli 
``````


### [GitPod lifecycle (before , Init ,Command )](https://www.gitpod.io/docs/configure/workspaces/tasks)

We need to be carefull when using init as it will not rerun if we restart an existing workspace 

### Working Env Var

### Env command

we can list all environment varaibles (Env Var) using the  command `env`

we can filter specific Env Var with using grep eg `env | grep AWS_`

### setting and unsetting Env Vars

In Terminal we can set using export `HELLO='world'`

In Terminal we can unset using  ` unset HELLO `

we can set an env var temporarily when just running a command 

```sh
HELLO='World' ./bin/print_message
```
within bash script we can set env without writting export eg.
```sh
#!/usr/bin/env bash

HELLO='World'

echo $HELLO
```

####Printing Vars

we can print env vars using echo eg ` echo $HELLO `

#### Scoping of Env Vars

when you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window 

If you wnat Env Vars to presist across all future bash terminals that are open , you need to set env vars in your bash profile eg. `.bash_profile`

#### Presisting Env Vars in Gitpod

we can presist env vars into gitpod by storing them in Gitpod secrtest storage.

```
gp env HELLO='World''
```
All future workspaces launched will set the env vars for all basj termianls opened in those workspaces.
we can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.