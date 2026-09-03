resource "yandex_vpc_network" "main" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public_a" {
  name           = "public-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.public_a_cidr]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "private-a"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.private_a_cidr]
}

resource "yandex_vpc_subnet" "public_b" {
  name           = "public-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.public_b_cidr]
}

resource "yandex_vpc_subnet" "private_b" {
  name           = "private-b"
  zone           = var.zone_b
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.private_b_cidr]
}
