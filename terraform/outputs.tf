output "external_ip_address_app_1" {
  value = yandex_compute_instance.app_1.network_interface.0.nat_ip_address
}
output "external_ip_address_app_2" {
  value = yandex_compute_instance.app_2.network_interface.0.nat_ip_address
}
output "external_ip_address_lb" {
  value = yandex_lb_network_load_balancer.lb.listener.*.external_address_spec.0
}