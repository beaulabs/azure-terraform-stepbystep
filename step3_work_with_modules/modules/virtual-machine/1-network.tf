resource "azurerm_public_ip" "pubip" {
  name                = "${var.prefix}-pubip"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  #public_ip_address_allocation = "static"
  allocation_method = "Static"
  domain_name_label = "${local.virtual_machine_name}"
  tags              = "${var.tags}"
}

resource "azurerm_network_interface" "mynic" {
  name                = "${var.prefix}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"

  ip_configuration {
    name                          = "IPConfiguration1"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pubip.id}"
  }
}
