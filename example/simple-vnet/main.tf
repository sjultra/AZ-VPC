terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "~> 1.43"
}

variable "instance_id" {

  default = "1234a"
  type    = string
}

variable "azure-region" {
  default = "eastus"
  type    = string
}

resource "azurerm_resource_group" "az-depl" {
  name     = "workspace-resources-${var.instance_id}"
  location = var.azure-region
}

module "vnet" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "github.com/sjultra/terraform-azure-network.git//modules/vnet?ref=v0.0.1"
  source = "../../modules/vnet"

  location = azurerm_resource_group.az-depl.location
  rg_name  = azurerm_resource_group.az-depl.name
}
