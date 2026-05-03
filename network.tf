resource "cloudru_evolution_compute_subnet" "example" {
  project_id = var.project_id

  name = "tf-evo-subnet"

  zone_identifier = {
    name = var.zone
  }

  description    = "Подсеть для ВМ"
  subnet_address = var.subnet_address
  routed_network = true
  default        = false
  vpc_id         = var.vpc_id

  dns_servers = {
    value = ["8.8.4.4", "8.8.8.8"]
  }
}

resource "cloudru_evolution_compute_security_group" "example" {
  project_id = var.project_id

  name = "tf-evo-sg"

  zone_identifier = {
    name = var.zone
  }

  description = "Группа безопасности для ВМ"
}

resource "cloudru_evolution_compute_security_group_rule" "ingress_ssh" {
  security_group_id = cloudru_evolution_compute_security_group.example.id
  direction         = "TRAFFIC_DIRECTION_INGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_TCP"
  port_range        = "22:22"
  description       = "SSH доступ с моего IP"
  remote_ip_prefix  = var.my_ip_cidr
}

resource "cloudru_evolution_compute_security_group_rule" "ingress_https" {
  security_group_id = cloudru_evolution_compute_security_group.example.id
  direction         = "TRAFFIC_DIRECTION_INGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_TCP"
  port_range        = "443:443"
  description       = "HTTPS доступ отовсюду"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "cloudru_evolution_compute_security_group_rule" "egress_tcp" {
  security_group_id = cloudru_evolution_compute_security_group.example.id
  direction         = "TRAFFIC_DIRECTION_EGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_TCP"
  port_range        = "1:65535"
  description       = "Разрешить весь исходящий TCP"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "cloudru_evolution_compute_security_group_rule" "egress_udp" {
  security_group_id = cloudru_evolution_compute_security_group.example.id
  direction         = "TRAFFIC_DIRECTION_EGRESS"
  ether_type        = "ETHER_TYPE_IPV4"
  ip_protocol       = "IP_PROTOCOL_UDP"
  port_range        = "1:65535"
  description       = "Разрешить весь исходящий UDP"
  remote_ip_prefix  = "0.0.0.0/0"
}
