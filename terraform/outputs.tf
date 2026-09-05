output "bastion_public_ip" {
  description = "Public IP address of Bastion host"
  value       = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "grafana_public_ip" {
  description = "Public IP address of Grafana"
  value       = yandex_compute_instance.grafana.network_interface[0].nat_ip_address
}

output "kibana_public_ip" {
  description = "Public IP address of Kibana"
  value       = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}

output "prometheus_private_ip" {
  description = "Private IP address of Prometheus"
  value       = yandex_compute_instance.prometheus.network_interface[0].ip_address
}

output "elasticsearch_private_ip" {
  description = "Private IP address of Elasticsearch"
  value       = yandex_compute_instance.elasticsearch.network_interface[0].ip_address
}

output "web_1_private_ip" {
  description = "Private IP address of web-1"
  value       = yandex_compute_instance.web_1.network_interface[0].ip_address
}

output "web_2_private_ip" {
  description = "Private IP address of web-2"
  value       = yandex_compute_instance.web_2.network_interface[0].ip_address
}

output "alb_public_ip" {
  description = "Public IPv4 address of Application Load Balancer"
  value = tolist(
    yandex_alb_load_balancer.web.listener[0].endpoint[0].address[0].external_ipv4_address
  )[0].address
}
