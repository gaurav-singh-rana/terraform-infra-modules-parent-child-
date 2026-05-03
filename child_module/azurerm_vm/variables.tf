variable "vm" {
  type = map(object({
    subnet_name                 = string
    virtual_network_name        = string
    resource_group_name         = string
    nic_name                    = string
    public_ip_name              = string
    nsg_name                    = string
    location                    = string
    vm_name                     = string
    admin_username              = string
    admin_password              = string
    public_ip_allocation_method = optional(string, "Static")

  }))

}
