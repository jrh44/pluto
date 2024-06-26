variable "project_id" {
  default = "roimb-devopsuser7-prod"
  type    = string
}

variable "project_number" {
  default="151122807805"
  type=string
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "topic" {
  default = "activities"
  type    = string
}

variable "function" {
  default = "pubsubtobq"
  type    = string
}

variable "function_sa" {
  default = "plutosa"
  type    = string
}

variable "bucketsuffix" {
  default = "-bucket"
  type    = string
}

variable "sourcebucketsuffix" {
  default = "-source"
  type    = string
}

variable "github_username" {
  default = "jrh44"
  type = string
}

variable "repo_name" {
  default = "pluto"
  type = string
}

variable "asset_list" {
    type = list(string)
    default = [
        "compute.googleapis.com/Instance",
        "compute.googleapis.com/Image",
        "compute.googleapis.com/Snapshot",
        "storage.googleapis.com/Bucket",
    ]
}

variable "service_list" {
    type = list(string)
    default = [
      "cloudasset.googleapis.com",
      "cloudbuild.googleapis.com",
      "cloudfunctions.googleapis.com",
      "containerregistry.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "iam.googleapis.com",
      "pubsub.googleapis.com",
      "sourcerepo.googleapis.com",
      "composer.googleapis.com",
    ]
}

variable "default_service_list" {
    type = list(string)
    default = [
      "bigquery.googleapis.com",
      "bigquerymigration.googleapis.com",
      "bigquerystorage.googleapis.com",
      "cloudapis.googleapis.com",
      #"clouddebugger.googleapis.com",
      "cloudtrace.googleapis.com",
      "eventarc.googleapis.com",
      "logging.googleapis.com",
      "monitoring.googleapis.com",
      "run.googleapis.com",
      "servicemanagement.googleapis.com",
      "serviceusage.googleapis.com",
      "sql-component.googleapis.com",
      "storage.googleapis.com",
      "storage-api.googleapis.com",
      "storage-component.googleapis.com"
    ]
}
