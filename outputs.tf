output "vm_id" {
  description = "ID виртуальной машины"
  value       = cloudru_evolution_compute_vm.example.id
}

output "vm_name" {
  description = "Имя виртуальной машины"
  value       = cloudru_evolution_compute_vm.example.name
}

output "vm_internal_ip" {
  description = "Внутренний IP адрес"
  value       = cloudru_evolution_compute_interface.example.ip_address
}

output "external_ip" {
  description = "Внешний IP адрес"
  value       = cloudru_evolution_compute_interface.example.external_ip.ip_address
}
