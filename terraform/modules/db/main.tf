resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  platform_id               = "standard-v2"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }

  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "../files/install_mongodb.sh"
  }

}
resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type  = "ssh"
    host  = yandex_compute_instance.db.network_interface[0].nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    content     = templatefile("${path.module}/files/mongod.conf", { db_ipaddr = yandex_compute_instance.db.network_interface.0.ip_address})
    destination = "/tmp/mongod.conf"
  }
  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}