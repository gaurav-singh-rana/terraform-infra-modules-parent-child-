# Terraform Azure Infrastructure with Parent and Child Modules

This project creates Azure infrastructure by using a simple `parent module` and multiple reusable `child modules`.

The code is written in a modular way so that the parent module controls what needs to be created, and the child modules contain the actual resource creation logic.

## Project Overview

This Terraform project currently creates:

- Resource Group
- Storage Account
- Virtual Network
- Subnet
- Linux Virtual Machine
- Public IP for the VM
- Network Security Group
- Inbound rules for:
  - SSH on port `22`
  - HTTP on port `80`

## Folder Structure

```text
parent_child/
|-- parent_module/
|   |-- provider.tf
|   |-- main.tf
|
|-- child_module/
|   |-- azurerm_rg/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |
|   |-- azurerm_stg/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |
|   |-- azurerm_vnet/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |
|   |-- azurerm_subnet/
|   |   |-- main.tf
|   |   |-- variables.tf
|   |
|   |-- azurerm_vm/
|       |-- main.tf
|       |-- variables.tf
|       |-- data.tf
|
|-- README.md
```

## How This Project Works

The project follows a very simple flow:

1. Terraform starts from the `parent_module`.
2. Azure provider is configured in `provider.tf`.
3. The parent module calls child modules one by one.
4. Each child module creates one type of Azure resource.
5. The VM module also creates:
   - Public IP
   - Network Security Group
   - Port `22` rule for SSH
   - Port `80` rule for HTTP
6. Finally, the Linux VM is created and connected to the subnet through a NIC.

## Module Details

### 1. Resource Group Module

Path: `child_module/azurerm_rg`

Purpose:
- Creates Azure Resource Groups

Input:
- Resource group name
- Location

### 2. Storage Account Module

Path: `child_module/azurerm_stg`

Purpose:
- Creates Azure Storage Account

Input:
- Storage account name
- Resource group name
- Location
- Account tier
- Replication type

### 3. Virtual Network Module

Path: `child_module/azurerm_vnet`

Purpose:
- Creates Azure Virtual Network

Input:
- VNet name
- Address space
- Resource group name
- Location

### 4. Subnet Module

Path: `child_module/azurerm_subnet`

Purpose:
- Creates subnet inside the VNet

Input:
- Subnet name
- VNet name
- Address prefix
- Resource group name

### 5. Virtual Machine Module

Path: `child_module/azurerm_vm`

Purpose:
- Creates Linux Virtual Machine
- Creates NIC
- Creates Public IP
- Creates NSG
- Opens SSH and HTTP ports

Input:
- VM name
- Admin username
- Admin password
- NIC name
- Public IP name
- NSG name
- Resource group name
- Location
- Subnet name
- VNet name

## Current Deployment Flow

Right now the infrastructure is created in this order:

1. Resource Group
2. Storage Account
3. Virtual Network
4. Subnet
5. Public IP
6. Network Security Group
7. NSG rules for port `22` and `80`
8. Network Interface
9. Linux Virtual Machine

## Important Files

### `parent_module/provider.tf`

Used for:
- Terraform provider configuration
- Azure subscription configuration

### `parent_module/main.tf`

Used for:
- Calling all child modules
- Passing values to each module

## How to Run This Project

Open terminal inside:

```powershell
parent_module
```

Then run:

```powershell
terraform init
terraform plan
terraform apply
```

## How to Destroy Resources

If you want to remove everything created by Terraform:

```powershell
terraform destroy
```

## Example of Current VM Configuration

The current VM setup includes:

- VM Name: `vm11-dev`
- Resource Group: `rg-dev`
- VNet: `dev-vnet`
- Subnet: `new-subnet`
- Public IP: `dev-vm11-pip`
- NSG: `dev-vm11-nsg`
- Open Ports:
  - `22` for SSH
  - `80` for HTTP

## Notes

- This project is using AzureRM provider version `4.70.0`
- Child modules are reusable
- Parent module is the main entry point
- VM is using Ubuntu image
- Password authentication is enabled in the current VM configuration

## Security Note

This project currently keeps the Azure subscription ID and VM admin password directly inside Terraform code.

For real project or production use, it is better to:

- Move secrets to `terraform.tfvars`
- Use environment variables
- Use Azure Key Vault
- Avoid keeping passwords in plain text

## Why This Structure Is Useful

This structure is easy to understand because:

- Parent module controls the full infrastructure
- Child modules keep the code reusable
- Each module has one clear responsibility
- Changes are easier to manage
- Code is cleaner than writing everything in one file

## Summary

This is a simple modular Terraform project for Azure infrastructure.

It creates the network, storage, and VM resources by calling reusable child modules from one parent module. The VM is accessible through a Public IP, and basic ports like `22` and `80` are opened using an NSG.
