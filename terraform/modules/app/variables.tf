variable zone {
  description = "Zone"
  # Значение по умолчанию
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable machine_type {
  description = "Type machine"
  default     = "g1-small"
}

variable "db_external_ip" {
  description = "DB address"
}

variable "db_internal_ip" {
  description = "internal DB address"
}
