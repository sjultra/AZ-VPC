variable "name_prefix" {
  description = "Name prefix of the vnet to create"
  default     = "sjultra-vnet"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space that is used by the virtual network."
  default     = ["10.244.0.0/16"]
  type        = list(string)
}

variable "subnet_address_prefix" {
  description = "The address space that is used by the virtual network."
  default     = "10.244.0.0/24"
  type        = string
}

variable "location" {
  description = "Location virtual network will be created in."
  default     = ""
  type        = string
}

variable "rg_name" {
  description = "Name of the resorce group the virtual network will be created in."
  default     = ""
  type        = string
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    environment = "dev"
  }
}
