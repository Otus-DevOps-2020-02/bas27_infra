resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["reddit-db"]
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    # путь до публичного ключа
    ssh-keys = "bas:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "bas"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  # provisioner "remote-exec" {
  #   script = "../modules/files/change_bind_mongo.sh"
  # }
}

# Правило firewall
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
