resource "yandex_compute_instance" "app" {
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

/*resource "yandex_vpc_network" "lab-net" {
  name = "lab-network"
}

resource "yandex_vpc_security_group" "group1" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.lab-net.id}"

  labels = {
    my-label = "my-label-value"
  }

  ingress {
    protocol       = "TCP"
    description    = "rule1 description"
    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    description    = "rule2 description"
    v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
    from_port      = 8090
    to_port        = 8099
  }

  egress {
    protocol       = "UDP"
    description    = "rule3 description"
    v4_cidr_blocks = ["10.0.1.0/24"]
    from_port      = 8090
    to_port        = 8099
  }
}*/