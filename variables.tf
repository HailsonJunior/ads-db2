variable "azure_location" {
  description = "Azure location where resource will be created"
  type        = string
  default     = "East US"
}

variable "allowed-ips" {
  type    = list(string)
  default = ["177.51.65.84", "200.133.218.108"]
}
