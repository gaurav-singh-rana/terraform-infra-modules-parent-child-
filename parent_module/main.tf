module "rg" {
  source = "../child_module/azurerm_rg"
  rgs = {
    rg1 = {
      name     = "rg-dev"
      location = "Central India"
    }

  }
}

module "stgs" {
  depends_on = [module.rg]
  source     = "../child_module/azurerm_stg"
  stgs = {
    stg1 = {
      stg_name                 = "stgaccountfrommodule1"
      resource_group_name      = "rg-dev"
      location                 = "Central India"
      account_tier             = "Standard"
      account_replication_type = "GRS"
    }
  }
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../child_module/azurerm_vnet"
  vnet = {
    vnet1 = {
      vnet_name           = "dev-vnet"
      location            = "Central India"
      resource_group_name = "rg-dev"
      address_space       = ["10.0.0.0/16"]

    }
  }
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../child_module/azurerm_subnet"
  subnets = {
    subnet1 = {
      name                 = "new-subnet"
      resource_group_name  = "rg-dev"
      virtual_network_name = "dev-vnet"
      address_prefixes     = ["10.0.1.0/24"]
    }
  }

}

module "vm" {
  depends_on = [module.subnet, module.vnet, module.rg]
  source     = "../child_module/azurerm_vm"
  vm = {
    vm1 = {
      subnet_name          = "new-subnet"
      virtual_network_name = "dev-vnet"
      resource_group_name  = "rg-dev"
      nic_name             = "dev-nic1"
      public_ip_name       = "dev-vm11-pip"
      nsg_name             = "dev-vm11-nsg"
      inbound_ports        = [22, 80]
      location             = "Central India"
      vm_name              = "vm11-dev"
      admin_username       = "devvm"
      admin_password       = "Dev@12345"

    }
  }

}
