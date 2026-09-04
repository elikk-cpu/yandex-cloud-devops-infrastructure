resource "yandex_vpc_security_group" "bastion" {
  name        = "sg-bastion"
  description = "SSH access to bastion host"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH from administrator public IP"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "alb" {
  name        = "sg-alb"
  description = "Security group for Application Load Balancer"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "Public HTTP traffic"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol          = "TCP"
    description       = "Load balancer health checks"
    port              = 30080
    predefined_target = "loadbalancer_healthchecks"
  }

  egress {
    protocol       = "ANY"
    description    = "Traffic from ALB to backends"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "prometheus" {
  name        = "sg-prometheus"
  description = "Security group for Prometheus"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol          = "TCP"
    description       = "SSH from bastion"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol          = "TCP"
    description       = "Prometheus access from Grafana"
    port              = 9090
    security_group_id = yandex_vpc_security_group.grafana.id
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "grafana" {
  name        = "sg-grafana"
  description = "Security group for Grafana"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "Grafana UI from administrator IP"
    port           = 3000
    v4_cidr_blocks = [var.admin_cidr]
  }

  ingress {
    protocol          = "TCP"
    description       = "SSH from bastion"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "kibana" {
  name        = "sg-kibana"
  description = "Security group for Kibana"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "Kibana UI from administrator IP"
    port           = 5601
    v4_cidr_blocks = [var.admin_cidr]
  }

  ingress {
    protocol          = "TCP"
    description       = "SSH from bastion"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web" {
  name        = "sg-web"
  description = "Security group for nginx web servers"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol          = "TCP"
    description       = "HTTP from Application Load Balancer"
    port              = 80
    security_group_id = yandex_vpc_security_group.alb.id
  }

  ingress {
    protocol          = "TCP"
    description       = "SSH from bastion"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol          = "TCP"
    description       = "Node Exporter metrics from Prometheus"
    port              = 9100
    security_group_id = yandex_vpc_security_group.prometheus.id
  }

  ingress {
    protocol          = "TCP"
    description       = "Nginx Log Exporter metrics from Prometheus"
    port              = 4040
    security_group_id = yandex_vpc_security_group.prometheus.id
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elasticsearch" {
  name        = "sg-elasticsearch"
  description = "Security group for Elasticsearch"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol          = "TCP"
    description       = "SSH from bastion"
    port              = 22
    security_group_id = yandex_vpc_security_group.bastion.id
  }

  ingress {
    protocol          = "TCP"
    description       = "Elasticsearch API from web servers"
    port              = 9200
    security_group_id = yandex_vpc_security_group.web.id
  }

  ingress {
    protocol          = "TCP"
    description       = "Elasticsearch API from Kibana"
    port              = 9200
    security_group_id = yandex_vpc_security_group.kibana.id
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
