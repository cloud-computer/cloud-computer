terraform {
  backend "gcs" {}
}

provider "google" {
  credentials = "${file("${var.cloud_provider_credentials_path}")}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
  region = "${var.machine_region}"
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

resource "google_compute_address" "cloud-computer" {
  name = "cloud-computer"
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

  labels {
    owner_host = "${var.CLOUD_COMPUTER_HOST_NAME}"
    owner_user = "${var.CLOUD_COMPUTER_HOST_USER}"
  }

  metadata {
    ssh-keys = "core:${tls_private_key.cloud-computer.public_key_openssh}"
  }

  network_interface {
    access_config {
      nat_ip = "${google_compute_address.cloud-computer.address}"
    }
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
      "export CLOUD_COMPUTER_REPOSITORY=${var.CLOUD_COMPUTER_REPOSITORY}",
      "export CLOUD_COMPUTER_REPOSITORY_VOLUME=${var.CLOUD_COMPUTER_REPOSITORY_VOLUME}",
      "export CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS='${file("${var.cloud_provider_credentials_path}")}'",
      "export CLOUD_COMPUTER_HOST_ID=${var.CLOUD_COMPUTER_HOST_ID}",
      "export CLOUD_COMPUTER_YARN_JAEGER_TRACE=${var.CLOUD_COMPUTER_YARN_JAEGER_TRACE}",

      "# Alias docker run with cloud computer environment",
      "alias docker_run=\"docker run --env CLOUD_COMPUTER_HOST_ID --env CLOUD_COMPUTER_CLOUD_PROVIDER_CREDENTIALS --env CLOUD_COMPUTER_YARN_JAEGER_TRACE --env DOCKER_HOST=localhost --interactive --rm --tty --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY --volume /var/run/docker.sock:/var/run/docker.sock --workdir $CLOUD_COMPUTER_REPOSITORY ${var.CLOUD_COMPUTER_REGISTRY}/cloud-computer\"",

      "# Create the CLOUD_COMPUTER_REPOSITORY volume",
      "docker run --rm --volume $CLOUD_COMPUTER_REPOSITORY_VOLUME:$CLOUD_COMPUTER_REPOSITORY chown -R 1000:1000 $CLOUD_COMPUTER_REPOSITORY",

      "# Clone the cloud computer repository",
      "docker_run git clone --branch master --depth 1 --quiet --single-branch https://github.com/cloud-computer/cloud-computer $CLOUD_COMPUTER_REPOSITORY",

      "# Start the cloud computer",
      "docker_run yarn --cwd infrastructure/cloud-computer start",
    ]
  }
}
