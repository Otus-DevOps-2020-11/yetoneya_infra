resource "yandex_compute_instance" "app" {
  depends_on = [yandex_vpc_security_group.security_group]
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
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
    security_group_ids = [
      yandex_vpc_security_group.security_group.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "null_resource" "app" {

  count = var.provisioners_enable

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

resource "yandex_vpc_security_group" "security_group" {

  name = "security group"
  network_id = var.network_id
  folder_id = var.folder_id

  labels = {
    my-label = "security"
  }

  ingress {
    protocol = "TCP"
    description = "description"

    port = 80
  }

}

