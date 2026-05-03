variable "vnet" {
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
  }))

}