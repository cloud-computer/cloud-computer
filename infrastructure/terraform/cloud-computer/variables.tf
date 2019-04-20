variable "cloud_provider_credentials_path" {
  description = "The path to the file containing credentials for accessing the cloud provider."
  default = "/cloud-computer/credentials/cloud-provider.json"
}

variable "docker_config_path" {
  description = "The Docker daemon config file path."
  default = "/cloud-computer/cloud-computer/infrastructure/credentials/docker.json"
}

variable "machine_region" {
  description = "The zone to create the machine in."
  default = "australia-southeast1"
}

variable "machine_type" {
  description = "The machine type."
  default = "custom-6-30720"
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

variable "tls_ca_cert_path" {
  description = "Path to file containing CA TLS certificate."
  default = "/cloud-computer/certificates/ca.pem"
}

variable "tls_cert_path" {
  description = "Path to file containing TLS certificate."
  default = "/cloud-computer/certificates/cert.pem"
}

variable "tls_key_path" {
  description = "Path to file containing TLS private key."
  default = "/cloud-computer/certificates/key.pem"
}

output "ip" {
  value = "${google_compute_instance.cloud-computer.network_interface.0.access_config.0.nat_ip}"
}
