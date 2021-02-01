resource "yandex_lb_network_load_balancer" "lb" {
  depends_on = [yandex_lb_target_group.lb_group]
  name = "balancer"
  listener {
    name = "listener"
    port = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_group.id
    healthcheck {
      name = "health"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}

variable "subnet_id" {
  description = "Subnet"
  default = "e9b0eh95ocin6vutga87"
}

resource "yandex_lb_target_group" "lb_group" {
  name = "group"
  depends_on = [yandex_compute_instance.app]
  dynamic "target" {
    for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
    content {
      subnet_id = var.subnet_id
      address = target.value
    }
  }
}