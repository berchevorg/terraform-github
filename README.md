# terraform-github
Guideline on HOW to create github repo with terraform

**Note that all this is tested on Ubuntu OS**

## Files 
- `main.tf` - Terraform configuration file
- `.kitchen.yml` - Kitchen configuration file
- `Gemfile` -  Specify the the ruby version, and all gems needed for Kitchen test
- `test/integration/default/default_test.rb` - based on this file kitchen is going to perform testing of our terraform code
- `<file>.env` - **ATTENTION! This file is not uploaded because contain sensitive information!** Contain Github token information needed to terraform in order to create github repo, plus definition of the rest used variables. Please create your own file (the name, before extention, is not really matters) in the following format:
  ```
  export TF_VAR_github_token=your_github_token
  export TF_VAR_repo=name_of_the_repo_you_want_to_create
  export TF_VAR_organization=name_of_your_organization
  ```
- `testing.tfvars` - **ATTENTION! This file is not uploaded because contain sensitive information!** Kitchen is going to use the variables in this file while creating the testing enironment. Please create your own file in the following format:
  ```
  github_token = "your_github_token"
  repo = "name_of_the_repo_you_want_to_create"
  organization = "name_of_your_organization"
  ```

## Requirements
- Terraform installed
- Generated github token
- kitchen tool installed

## Generating of github token
- Sign in with your github account into the [github website](https://github.com)
- From drop-down menu in upper right corner choose **Settings**
- Choose **Developer settings**
- Click on **Personal access tokens**
- Click on **Generate new token**
- Give your token a descriptive name
- Select permissions, you'd like to grant this token:
  - repo
  - admin:org
  - delete_repo
- Cleck **Generate token**
- **ATTENTION**: Make sure to copy your new personal access token once created. You won’t be able to see it again! 
- Make sure you add your github token information to `<file>.env`. For more information take a look at **Files** section

## Installing Terraform
- Download required package from [here](https://www.terraform.io/downloads.html)
- Change to directory where package is download. For example: `cd $HOME/Downloads/` 
- Type on your terminal: `unzip <Downloaded_TF_Package>`
- Type on your terminal: `sudo mv terraform /usr/local/bin/`
- Check whether Terraform is available with:  `terraform --version` command

## Using this Terraform project
- Download the repo **berchevorg/terraform-github**: `git clone https://github.com/berchevorg/terraform-github.git`
- Change to berchevorg/terraform-github: `cd terraform-github`
- Create a file which ends on **.env** (check **Files** section)
- Type in your terminal `. <file>.env` or `source <file>.env`, in order to export AWS data as env variables
- Type in your terminal `terraform init` in order to be downloaded required providers
- Type in your terminal `terraform plan` in order to see the changes which terraform is going to be made
- Type in your terminal `terraform apply` execute changes bases on our code(main.tf)
- Go to your github organization to check for newly created repo

## Remove all created with Terraform
- Type in your terminal `terraform destroy` in order to delete created github repo with terraform

## Prepare your environment for **kitchen**
- Type: `sudo apt-get install rbenv ruby-dev ruby-bundler`
- add to your ~/.bash_profile: 
```
eval "$(rbenv init -)"
true
export PATH="$HOME/.rbenv/bin:$PATH"
```
- do `. ~/.bash_profile` in order to apply the changes made in .bash_profile

## Test your code with **kitchen**
- Create `testing.tfvars` file according to the instructions in **Files** section
- Change to the directory with `Gemfile` and type: `bundle install --path vendor/bundle` in order to install all needed gems for the test
- Type: `bundle exec kitchen list` to list the environment
- Type: `bundle exec kitchen converge` to build environment with kitchen
- Type: `bundle exec kitchen verify` to test the created kitchen environment
- Type: `bundle exec kitchen destroy` in order to destroy the created kitchen environment
- Type: `bundle exec kitchen test` in order to do steps from 3 to 5 in one command

## TODO
