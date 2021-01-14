resource "yandex_compute_instance" "app" {
  name = "reddit-app-a"

  labels = {
    tags = "reddit-app-a"
  }

  resources {
    cores = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
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

resource "null_resource" "app" {

  count = var.provisioner_enabled

  connection {
    type = "ssh"
    host = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

  provisioner "local-exec" {
    command = "sed 's/DB_ADDRESS/${var.db_address}/g' ${path.module}/files/puma.service.templ > ${path.module}/files/puma.service"
  }

  provisioner "file" {
    source = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  #provisioner "file" {
  #  content = templatefile("${path.module}/files/puma.service", {
  #    Environment = {
  #      DATABASE_URL = "${var.db_address}:27017"
  #    }
  #  })
  #  destination = "/tmp/puma.service"
  #}

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
