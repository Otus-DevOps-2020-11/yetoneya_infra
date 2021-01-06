provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  zone = var.zone
}

resource "yandex_compute_instance" "app_1" {
  name = "reddit-app-terraform-1"
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  metadata = {
    user-data = file("files/metadata.yaml")
  }
  connection {
    type = "ssh"
    host = yandex_compute_instance.app_1.network_interface.0.ip_address
    user = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }
}
resource "yandex_compute_instance" "app_2" {
  name = "reddit-app-terraform-2"
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }
  metadata = {
    user-data = file("files/metadata.yaml")
  }
  connection {
    type = "ssh"
    host = yandex_compute_instance.app_2.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

}
