resource "yandex_compute_instance" "db" {
  name = "reddit-db-a"
  labels = {
    tags = "reddit-db-a"
  }

  resources {
    cores = 2
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
}

resource "null_resource" "db" {

  count = var.provisioners_enable

  connection {
    type = "ssh"
    host = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

}
