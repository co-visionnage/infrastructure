variable "project_id" {
  type        = string
  description = "Идентификатор проекта из console.cloud.ru"
}

variable "auth_key_id" {
  type        = string
  description = "Идентификатор ключа доступа сервисного аккаунта"
  sensitive   = true
}

variable "auth_secret" {
  type        = string
  description = "Секрет ключа доступа сервисного аккаунта"
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "Идентификатор VPC"
}

variable "my_ip_cidr" {
  type        = string
  description = "CIDR вашего IP-адреса для доступа по SSH (например 1.2.3.4/32)"
}

variable "subnet_address" {
  type        = string
  description = "CIDR подсети"
  default     = "10.0.0.0/24"
}

variable "vm_name" {
  type        = string
  description = "Имя виртуальной машины"
  default     = "tf-evo-vm"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Путь к публичному SSH ключу"
  default     = "~/.ssh/id_rsa.pub"
}

variable "disk_size" {
  type        = number
  description = "Размер диска в ГБ"
  default     = 20
}

variable "disk_type" {
  type        = string
  description = "Тип диска"
  default     = "SSD"
}

variable "flavor" {
  type        = string
  description = "Flavor ВМ"
  default     = "gen-1-1"
}

variable "zone" {
  type        = string
  description = "Зона доступности"
  default     = "ru.AZ-1"
}
