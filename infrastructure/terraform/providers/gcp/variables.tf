variable "cloud_provider_credentials_path" {
  description = "The path to the file containing credentials for accessing the cloud provider."
  default = "/cloud-computer/credentials/cloud-provider.json"
}

variable "machine_type" {
  description = "The machine type."
  default = "custom-4-12288"
}

variable "CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT" {
  description = "The cloud provider project to create the machine in."
}

variable "CLOUD_COMPUTER_DNS_DOMAIN" {
  description = "The domain name of the dns account."
}

variable "CLOUD_COMPUTER_DNS_TOKEN" {
  description = "The token to access the dns account."
}

variable "CLOUD_COMPUTER_DNS_ZONE" {
  description = "The dns account zone to update."
}

variable "CLOUD_COMPUTER_GIT_BRANCH" {
  description = "The current git branch."
}

variable "CLOUD_COMPUTER_GIT_URL" {
  description = "The current git url."
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

variable "CLOUD_COMPUTER_REGION" {
  description = "The region to create the cloud computer virtual machine in."
  default = "australia-southeast1"
}


variable "CLOUD_COMPUTER_YARN_JAEGER_TRACE" {
  description = "The current cloud computer jaeger trace id."
  default = ""
}

variable "GIT_COMMITTER_EMAIL" {
  description = "The current git user email."
  default = ""
}

variable "GIT_COMMITTER_NAME" {
  description = "The current git user name."
  default = ""
}

output "ip" {
  value = "${google_compute_address.cloud-computer.address}"
}
