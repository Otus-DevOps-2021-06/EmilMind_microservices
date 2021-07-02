output "external_ip_addresses_app" {
  value = toset([
    for instanse in yandex_compute_instance.app : instanse.network_interface.0.nat_ip_address
  ])
}

