resource "yandex_lb_network_load_balancer" "lb" {
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
        port = 80
        path = "/ping"
      }
    }
  }
}
resource "yandex_lb_target_group" "lb_group" {
  name = "group"
  target {
    address = yandex_compute_instance.app_1.network_interface.0.ip_address
    subnet_id = var.subnet_id
  }
  target {
    address = yandex_compute_instance.app_2.network_interface.0.ip_address
    subnet_id = var.subnet_id
  }
}