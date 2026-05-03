terraform {
  required_providers {
    cloudru = {
      source  = "cloud.ru/cloudru/cloud"
      version = "2.0.0"
    }
  }
}

provider "cloudru" {
  project_id  = var.project_id
  auth_key_id = var.auth_key_id
  auth_secret = var.auth_secret

  endpoints = {
    iam_endpoint     = "iam.api.cloud.ru:443"
    compute_endpoint = "compute.api.cloud.ru:443"
  }
}

data "cloudru_evolution_compute_image_collection" "ubuntu" {
  project_id = var.project_id
  page_size  = 100
}

locals {
  cloud_config = templatefile("${path.module}/cloud-init.yaml.tpl", {
    ssh_public_key = file(var.ssh_public_key_path)
    vm_name        = var.vm_name
  })
}

resource "cloudru_evolution_compute_disk" "example" {
  project_id = var.project_id

  name = "tf-evo-disk"
  size = var.disk_size

  zone_identifier = {
    name = var.zone
  }

  disk_type_identifier = {
    name = var.disk_type
  }

  description = "Загрузочный диск для ВМ"
  bootable    = true
  image_id    = [for img in data.cloudru_evolution_compute_image_collection.ubuntu.images : img.id if img.name == "ubuntu-22.04"][0]
  encrypted   = false
  readonly    = false
  shared      = false
}

resource "cloudru_evolution_compute_interface" "example" {
  project_id = var.project_id

  name = "tf-evo-interface"

  zone_identifier = {
    name = var.zone
  }

  description                = "Сетевой интерфейс для ВМ"
  subnet_id                  = cloudru_evolution_compute_subnet.example.id
  interface_security_enabled = true

  security_groups_identifiers = {
    value = [{
      id = cloudru_evolution_compute_security_group.example.id
    }]
  }

  external_ip_specs = {
    new_external_ip = true
  }

  type = "INTERFACE_TYPE_REGULAR"
}

resource "cloudru_evolution_compute_vm" "example" {
  project_id = var.project_id

  name = var.vm_name

  zone_identifier = {
    name = var.zone
  }

  flavor_identifier = {
    name = var.flavor
  }

  description = "ВМ, созданная через Terraform"

  disk_identifiers = [{
    disk_id = cloudru_evolution_compute_disk.example.id
  }]

  network_interfaces = [{
    interface_id = cloudru_evolution_compute_interface.example.id
  }]

  cloud_init_userdata = base64encode(local.cloud_config)
}
