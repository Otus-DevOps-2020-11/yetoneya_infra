variable public_key_path {
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/id_rsa.pub"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
  default = "~/.ssh/yc"
}

variable subnet_id {
  description = "Subnet"
  default = "e9b0eh95ocin6vutga87"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default = "fd8m1kq78ciiv0u8slbn"
}

variable db_ipaddr {
  description = "Database IP address"
  default = ""
}