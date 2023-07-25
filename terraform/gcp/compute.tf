resource "google_compute_firewall" "ssh-rule" {
  name = "ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["bastion-host"]
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_instance" "runner" {
  name         = "loadtest-runner"
  machine_type = "custom-4-16384"
  zone         = var.compute_zone
  tags         = ["bastion-host"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  metadata = {
    ssh-keys = "root:${file(var.ssh_key_file_path)}"
  }

  network_interface {
    network = google_compute_network.vpc.id

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  allow_stopping_for_update = true
}