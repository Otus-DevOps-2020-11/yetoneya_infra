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

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "fd8fn7lc7aa3tk3dnd0n"
}