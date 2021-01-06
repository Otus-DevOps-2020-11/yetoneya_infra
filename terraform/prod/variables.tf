variable cloud_id {
  default = "b1grsn3elgjuhte25am3"
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
  default = "b1gbj6r7clnrmifr988p"
}
variable zone {
  description = "Zone"
  default = "ru-central1-a"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/id_rsa.pub"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
  default = "~/.ssh/yc"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "fd8fn7lc7aa3tk3dnd0n"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "fd8m1kq78ciiv0u8slbn"
}

variable subnet_id {
  description = "Subnet"
  type = string
  default = "e9b0eh95ocin6vutga87"
}
variable service_account_key_file {
  description = "Key"
  type = string
  default = "key.json"
}
variable count_app {
  description = "Vm amount"
  type = number
  default = 1
}
