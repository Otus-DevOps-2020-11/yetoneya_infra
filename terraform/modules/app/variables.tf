variable public_key_path {
  description = "Path to the public key used for ssh access"
  default = ""
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
  default = ""
}
variable subnet_id {
  description = "Subnet"
  default = ""
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = ""
}
variable db_ipaddr {
  description = "Database IP address"
  default = ""
}