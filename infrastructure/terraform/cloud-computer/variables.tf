variable "cloud_provider_credentials_path" {
  description = "The path to the file containing credentials for accessing the cloud provider."
  default = "/cloud-computer/credentials/cloud-provider.json"
}

variable "machine_region" {
  description = "The zone to create the machine in."
  default = "australia-southeast1"
}

variable "machine_type" {
  description = "The machine type."
  default = "custom-6-20480"
}

variable "CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT" {
  description = "The cloud provider project to create the machine in."
}

variable "CLOUD_COMPUTER_DNS_EMAIL" {
  description = "The email address of the dns account."
}

variable "CLOUD_COMPUTER_DNS_TOKEN" {
  description = "The token to access the dns account."
}

variable "CLOUD_COMPUTER_DNS_ZONE" {
  description = "The dns account zone to update."
}

variable "CLOUD_COMPUTER_HOST_ID" {
  description = "The id of the machine that created the instance."
}

variable "CLOUD_COMPUTER_HOST_NAME" {
  description = "The hostname of the machine that created the instance."
}

variable "CLOUD_COMPUTER_HOST_USER" {
  description = "The username of the user that created the instance."
}

variable "CLOUD_COMPUTER_IMAGE" {
  description = "The cloud computer docker image."
}

variable "CLOUD_COMPUTER_REPOSITORY" {
  description = "The cloud computer repoisitory path."
}

variable "CLOUD_COMPUTER_REPOSITORY_VOLUME" {
  description = "The cloud computer repoisitory volume name."
}

variable "CLOUD_COMPUTER_YARN_JAEGER_TRACE" {
  description = "The current cloud computer jaeger trace id."
  default = ""
}

variable "GIT_AUTHOR_EMAIL" {
  description = "The current git user email."
  default = ""
}

variable "GIT_AUTHOR_NAME" {
  description = "The current git user name."
  default = ""
}

variable "GIT_BRANCH" {
  description = "The current git branch."
  default = "master"
}

output "ip" {
  value = "${google_compute_address.cloud-computer.address}"
}
