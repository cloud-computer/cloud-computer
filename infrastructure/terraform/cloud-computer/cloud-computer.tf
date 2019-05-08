terraform {
  backend "gcs" {}
}

provider "google" {
  credentials = "${file("${var.cloud_provider_credentials_path}")}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
}

resource "tls_private_key" "cloud-computer" {
  algorithm = "RSA"
  count = "1"
  rsa_bits  = 4096
}

resource "random_id" "instance_id" {
  byte_length = 2
}

locals {
  environment_name = "cloud-computer-${var.CLOUD_COMPUTER_HOST_ID}-${random_id.instance_id.hex}"
}

resource "google_compute_firewall" "cloud-computer" {
  name = "${local.environment_name}"
  network = "${google_compute_network.cloud-computer.name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  target_tags = ["${local.environment_name}"]

  allow {
    protocol = "icmp"
  }

  allow {
    ports = [
      "22",
      "80",
      "443",
    ]
    protocol = "tcp"
  }
}

resource "google_compute_network" "cloud-computer" {
  auto_create_subnetworks = false
  name = "${local.environment_name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
}

resource "google_compute_subnetwork" "cloud-computer" {
  ip_cidr_range = "10.2.0.0/16"
  name = "${local.environment_name}"
  network = "${google_compute_network.cloud-computer.name}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  region = "${var.machine_region}"
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
      image = "cos-cloud/cos-dev"
      type = "pd-ssd"
      size = "100"
    }
  }

  labels {
    owner_host = "${var.CLOUD_COMPUTER_HOST_NAME}"
    owner_user = "${var.CLOUD_COMPUTER_HOST_USER}"
  }

  metadata {
    ssh-keys = "core:${tls_private_key.cloud-computer.public_key_openssh}"
  }

  network_interface {
    access_config {}
    subnetwork = "${google_compute_subnetwork.cloud-computer.name}"
    subnetwork_project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  }

  provisioner "remote-exec" {
    connection {
      agent = false
      private_key = "${tls_private_key.cloud-computer.private_key_pem}"
      type = "ssh"
      user = "core"
    }

    inline = [
      "# Set cloud computer environment",
      "export CLOUD_COMPUTER_BACKEND=${var.CLOUD_COMPUTER_BACKEND}",
      "export CLOUD_COMPUTER_BACKEND_VOLUME=${var.CLOUD_COMPUTER_BACKEND_VOLUME}",
      "export CLOUD_COMPUTER_HOST_ID=${var.CLOUD_COMPUTER_HOST_ID}",

      "# Target the local docker socket",
      "export DOCKER_HOST=unix:///var/run/docker.sock",

      "# Alias docker run",
      "alias docker_run=\"docker run --env CLOUD_COMPUTER_HOST_ID --env DOCKER_HOST --interactive --rm --tty --volume $CLOUD_COMPUTER_BACKEND_VOLUME:$CLOUD_COMPUTER_BACKEND --volume /var/run/docker.sock:/var/run/docker.sock --workdir $CLOUD_COMPUTER_BACKEND ${var.CLOUD_COMPUTER_REPOSITORY}/bootstrap\"",

      "# Clone the cloud computer",
      "docker_run git clone --branch master --depth 1 --quiet --single-branch https://github.com/cloud-computer/cloud-computer $CLOUD_COMPUTER_BACKEND",

      "# Expose the docker socket",
      "docker_run yarn --cwd infrastructure/docker-compose up:docker",
      "docker_run yarn --cwd infrastructure/docker-compose up:traefik",

      "# Cache the cloud computer image",
      "docker pull ${var.CLOUD_COMPUTER_REPOSITORY}/cloud-computer &",

      "# Hack: Wait until dns has updated, then restart let's encrypt request",
      "sleep 15 && docker ps -q | xargs docker restart &",
    ]
  }
}
