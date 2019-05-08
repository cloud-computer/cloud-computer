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
  default = "custom-2-8192"
}

variable "CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT" {
  description = "The cloud provider project to create the machine in."
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
  description = "The cloud computer docker image name."
}

variable "CLOUD_COMPUTER_REGISTRY" {
  description = "The cloud computer docker repository name."
}

variable "CLOUD_COMPUTER_REPOSITORY" {
  description = "The cloud computer repoisitory path."
}

variable "CLOUD_COMPUTER_REPOSITORY_VOLUME" {
  description = "The cloud computer repoisitory volume name."
}

output "ip" {
  value = "${google_compute_instance.cloud-computer.network_interface.0.access_config.0.nat_ip}"
}
