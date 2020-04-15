resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["reddit-app"]
  boot_disk {
    initialize_params { image = var.app_disk_image }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "bas:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = google_compute_address.app_ip.address
    user  = "bas"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  # provisioner "file" {
  #   source      = "../modules/files/puma.service"
  #   destination = "/tmp/puma.service"
  # }

  # provisioner "remote-exec" {
  #   inline = ["sed -i s/db_external_ip/${var.db_internal_ip}/ /tmp/puma.service"]
  # }
  # provisioner "remote-exec" {
  #   script = "../modules/files/deploy.sh"
  # }

}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
