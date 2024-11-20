terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.7.0"
    }
  }
  backend "remote" {
    organization = "SAP_BTP_Terraform_Test"
    workspaces {
      name = "sap_btp_poc1"
    }
  }
}

# Please checkout documentation on how best to authenticate against SAP BTP
# via the Terraform provider for SAP BTP
provider "btp" {
  globalaccount = var.globalaccount
  username      = "S0026116057"
  password      = "@143Bubchoo"
}