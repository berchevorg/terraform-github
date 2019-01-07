
variable "github_token" {
  description = "Github token generated from github.com"
}


variable "repo" {
  description = "The name of repo which will be created"
}

variable "organization" {
  description = "Github organization name"
}

provider "github" {
  token        = "${var.github_token}"
  organization = "${var.organization}"
}

resource "github_repository" "tf-github" {
  name        = "${var.repo}"
  description = "This is a github repo created with terraform"
}
