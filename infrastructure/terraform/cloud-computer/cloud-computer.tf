terraform {
  backend "gcs" {}
}

provider "google" {
  credentials = "${file("${var.cloud_provider_credentials_path}")}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
}

resource "random_id" "instance_id" {
  byte_length = 2
}

resource "tls_private_key" "cloud-computer" {
  count = "1"
  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  environment_name = "cloud-computer-${var.CLOUD_COMPUTER_HOST_ID}-${random_id.instance_id.hex}"
}

resource "google_compute_instance" "cloud-computer" {
  allow_stopping_for_update = true
  machine_type = "${var.machine_type}"
  name = "${local.environment_name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  tags = ["${local.environment_name}"]
  zone = "${var.machine_region}-a"

  boot_disk {
    initialize_params {
      image = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}/cloud-computer"
      type = "pd-ssd"
      size = "100"
    }
  }

  network_interface {
    access_config {}
    subnetwork = "${google_compute_subnetwork.cloud-computer.name}"
    subnetwork_project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  }

  labels {
    owner_host = "${var.CLOUD_COMPUTER_HOST_NAME}"
    owner_user = "${var.CLOUD_COMPUTER_HOST_USER}"
  }

  metadata {
    ssh-keys = "root:${tls_private_key.cloud-computer.private_key_pem}"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      private_key = "${tls_private_key.cloud-computer.public_key_openssh}"
      agent = false
    }

    inline = [
      "# Install docker",
      "apt-get update -qq",
      "apt-get install -qq docker.io",

      "# Supply docker daemon configuration using cloud computer certificates",
      "echo '${file("${var.docker_config_path}")}' > /etc/docker/daemon.json",
      "echo '${file("${var.tls_ca_cert_path}")}' > /etc/docker/ca.pem",
      "echo '${file("${var.tls_cert_path}")}' > /etc/docker/cert.pem",
      "echo '${file("${var.tls_key_path}")}' > /etc/docker/key.pem",

      "# Override default docker daemon config",
      "mkdir -p /etc/systemd/system/docker.service.d",
      "printf '[Service]\nExecStart=\nExecStart=/usr/bin/dockerd' > /etc/systemd/system/docker.service.d/override.conf",
      "systemctl daemon-reload",
      "service docker restart",

      "# Make the docker socket accessible to the docker group",
      "chown :999 /var/run/docker.sock",
    ]
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
    ]
  }
}

resource "google_compute_firewall" "cloud-computer" {
  name = "${local.environment_name}"
  network = "${google_compute_network.cloud-computer.name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"

  allow {
    protocol = "icmp"
  }

  allow {
    ports = [
      "22",
      "80",
      "443",
      "2375",
    ]
    protocol = "tcp"
  }

  target_tags = ["${local.environment_name}"]
}

resource "google_compute_subnetwork" "cloud-computer" {
  name = "${local.environment_name}"
  ip_cidr_range = "10.2.0.0/16"
  network = "${google_compute_network.cloud-computer.name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  region = "${var.machine_region}"
}

resource "google_compute_network" "cloud-computer" {
  auto_create_subnetworks = false
  name = "${local.environment_name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
}
