# ------------------------------------------------------------------------------------------------------
# Required provider
# ------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.7.0"
    }
  }
}

# ------------------------------------------------------------------------------------------------------
# Setup Integration Suite entitlement
# ------------------------------------------------------------------------------------------------------
# Entitlement - "integrationsuite-trial" is the module

### Check if the entitlement already exists - if it does do not create a new one

resource "btp_subaccount_entitlement" "integrationsuite-trial" {
  subaccount_id = var.subaccount_id
  service_name  = "integrationsuite-trial"
  plan_name     = "trial"
  amount        = 1
}

#### - How to get the app name ???
#appname is assigned post entitlement assignment

# Subscribe
resource "btp_subaccount_subscription" "integrationsuite-trial" {
  subaccount_id = var.subaccount_id       #req
  app_name      = "it-cpitrial06-prov"    #req
  plan_name     = "trial"                 #req
  depends_on    = [btp_subaccount_entitlement.integrationsuite-trial]
  parameters = jsonencode({
  additional_features = ["build-integration-scenarios"] # Example if applicable
})
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
# Get all available subaccount roles
data "btp_subaccount_roles" "all" {
  subaccount_id = var.subaccount_id
  depends_on    = [btp_subaccount_subscription.integrationsuite-trial, btp_subaccount_entitlement.integrationsuite-trial]
}


# Create role collection "Build Code Administrator"
resource "btp_subaccount_role_collection" "Integration_Suite_Admin" {
  subaccount_id = var.subaccount_id
  name          = "Integration Suite Administrator"
  description   = "The role collection for an administrator on Integration Suite"

  roles = [
    for role in data.btp_subaccount_roles.all.values : {
      name                 = role.name
      role_template_app_id = role.app_id
      role_template_name   = role.role_template_name
    } if contains(["IntegrationProvisioningAdmin", "Administrator", "AuthGroup_Administrator", "AuthGroup_BusinessExpert", "AuthGroup_ContentPublisher", "AuthGroup_IntegrationDeveloper"], role.role_template_name)
  ]
}

# Assign users to the role collection "Integration Suite Administrator"
resource "btp_subaccount_role_collection_assignment" "Integration_Suite_Admin" {
  for_each             = toset(var.integration_suite_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Integration Suite Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_role_collection.Integration_Suite_Admin]
}