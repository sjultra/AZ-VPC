variable "name_prefix" {
  description = "Name prefix of the vnet to create"
  default     = "sjultra"
  type        = string
}

variable "vnets" {
  type = map(object({
    cidr_block = string
    subnets    = map(object({ cidr_block = string }))
  }))

  default = {
    "1" = {
      cidr_block = "10.244.0.0/16",
      subnets = {
        "1" = { cidr_block = "10.244.1.0/24" },
        "2" = { cidr_block = "10.244.2.0/24" },
      }
    },
  }
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
