terraform {
  backend "remote" {
    organization = "navigill"     # Replace with your Terraform Cloud org name

    workspaces {
      name = "strapi_project"              # Must match the workspace you created
    }
  }
}
