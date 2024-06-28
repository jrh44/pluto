provider "google" {
    project = var.project_id
    region = var.region
}

provider "github" {
  token = var.git_secret
}