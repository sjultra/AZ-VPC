resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name_prefix}-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}
resource "azurerm_subnet" "subnet" {
  name                 = "${var.name_prefix}-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.subnet_address_prefix
  lifecycle {
    ignore_changes = [
      route_table_id,
      network_security_group_id,
    ]
  }
}


resource "azurerm_route_table" "route-subnet" {
  name                = "${var.name_prefix}-route-subnet"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_subnet_route_table_association" "vnet-assoc" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.route-subnet.id
}
