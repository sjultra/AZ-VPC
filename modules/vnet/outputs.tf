output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = [for vnet_key, vnet in var.vnets : azurerm_virtual_network.vnet[vnet_key].id]
}

output "vnet_name" {

  description = "The Name of the newly created vNet"
  value       = [for vnet_key, vnet in var.vnets : azurerm_virtual_network.vnet[vnet_key].name]
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = [for vnet_key, vnet in var.vnets : azurerm_virtual_network.vnet[vnet_key].address_space]
}
