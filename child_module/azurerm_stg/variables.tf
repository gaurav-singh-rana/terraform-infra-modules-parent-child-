variable "stgs" {
  type = map(object({
    stg_name                 = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))

}