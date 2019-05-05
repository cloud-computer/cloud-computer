terraform {
  backend "gcs" {}
}

provider "google" {
  credentials = "${file("${var.cloud_provider_credentials_path}")}"
  project = "${var.CLOUD_COMPUTER_CLOUD_PROVIDER_PROJECT}"
}

locals {
  environment_name = "cloud-computer-${var.CLOUD_COMPUTER_HOST_ID}"
}

resource "tls_private_key" "cloud-computer" {
  count = "1"
  algorithm = "RSA"
  rsa_bits  = 4096
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
      image = "ubuntu-minimal-1904"
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
    ssh-keys = "root:${tls_private_key.cloud-computer.public_key_openssh}"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      private_key = "${tls_private_key.cloud-computer.private_key_pem}"
      agent = false
    }

    inline = [
      "# Increase max open files on host",
      "echo 'fs.file-max=1000000' >> /etc/sysctl.conf",

      "# Increase max open file watchers on host",
      "echo 'fs.inotify.max_user_watches=1000000' >> /etc/sysctl.conf",

      "# Support ipv4 forwarding in docker",
      "echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf",

      "# Increase max virtual memory maps",
      "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf",

      "# Increase file descriptor limit",
      "echo '* soft nofile 1000000' >> /etc/security/limits.conf",
      "echo '* hard nofile 1000000' >> /etc/security/limits.conf",

      "# Install bootstrap utilities",
      "apt-get update -qq",
      "apt-get install -qq docker.io docker-compose git yarn",

      "# Bootstrap the cloud computer",
      "git clone https://github.com/cloud-computer/cloud-computer",
      "cd cloud-computer",
      "yarn --cwd infrastructure/docker-compose up",
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
