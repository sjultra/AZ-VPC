resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnets
  name                = "${var.name_prefix}-vnet-${each.key}"
  address_space       = [each.value.cidr_block]
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

locals {
  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.
  vnet_subnets = flatten([
    for vnet_key, vnet in var.vnets : [
      for subnet_key, subnet in vnet.subnets : {
        vnet_key   = vnet_key
        subnet_key = subnet_key
        vnet_name  = azurerm_virtual_network.vnet[vnet_key].name
        cidr_block = subnet.cidr_block
      }
    ]
  ])
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in local.vnet_subnets : "${subnet.vnet_key}-${subnet.subnet_key}" => subnet
  }
  name                = "${var.name_prefix}-subnet-${each.key}"
  resource_group_name = var.rg_name

  virtual_network_name = each.value.vnet_name
  address_prefix       = each.value.cidr_block
  lifecycle {
    ignore_changes = [
      route_table_id,
      network_security_group_id,
    ]
  }
}

resource "azurerm_route_table" "route-table" {
  for_each            = var.vnets
  name                = "${var.name_prefix}-route-table-${each.key}"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet_route_table_association" "vnet-assoc" {
  for_each = {
    for subnet in local.vnet_subnets : "${subnet.vnet_key}-${subnet.subnet_key}" => subnet
  }
  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.route-table[each.value.vnet_key].id
}


#toDo vnet peering 
