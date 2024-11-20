#------------------------------------------------------------------------------------#
# Governance Modal - Landscape Strategy
#------------------------------------------------------------------------------------#
# Global Account
# 1. Every Global account should have atleast 2 Administrators
#
# Subaccount
# 1. For a staged Developement, create atleast 3 Subaccounts per MF per Workstream
# 2. Naming Convention - <<Work Stream>>_<<Member Firm>>_<<System Identifier>>
# 3. Subdomain should contain only lower case characters
# 4. Subdomain for the subaccount should be a uuid
#
# Entitlements
# 1. The Global Account administrator should provision Entitlements to Subaccounts
#
# Service Subscriptions
# 1. Global Services Catalogue, a document that has info on all the Services that a
#    Global Account is Entitled to, should be maintained
# 2. Local Services Catalogue, a document that has info on all the Services plans 
#    that are assigned to the Subaccount, should be maintained
# 3. The Subaccount Administrator should create Service instances or subscriptions
# 4. All Global Account Administrators should be Subaccount Administrators
#
# Role Collections
# 1. Every Service Subscription or Instance must have atleast 2 Role Colelctions
#    - Service Administrator and Service Developer
# 2. Users Onboarding should be performed using the User Onboarding document
#


# Create a random uuid to append to the Subaccount's Subdomain
resource "random_uuid" "uuid" {}

# Subaccount Domain Name
# locals {
#   subaccount_domain = lower(replace("${var.subaccount_domain_prefix}-
#   ${random_uuid.uuid.result}", "_", "-"))
#}

locals {
  subaccount_domain = lower(replace("${random_uuid.uuid.result}", "_", "-"))
}

# Create the subaccount
# Syntax - A resource block declares a resource of a specific type with a specific 
# local name. 'sa_build' is the local name of the Subaccount 
resource "btp_subaccount" "sa_build" {
  name      = var.subaccount_name
  subdomain = local.subaccount_domain
  region    = lower(var.region)
}

# As the Global Account administrator, when I create a Subaccount I am automatically  
# added as a subaccount administrator


/*
#------------------------------------------------------------------------------------#
# Set up Entitlements, service subscription and Role Collections
#------------------------------------------------------------------------------------#
# A module is a container for multiple resources that are used together
module "build_code" {
  #Path to the local file directory 
  source = "./modules/build_code/"

  subaccount_id = btp_subaccount.sa_build.id

  application_studio_admins             = var.application_studio_admins
  application_studio_developers         = var.application_studio_developers
  application_studio_extension_deployer = var.application_studio_extension_deployer

  build_code_admins     = var.build_code_admins
  build_code_developers = var.build_code_developers
}


#------------------------------------------------------------------------------------#
# Set up Entitlements, service subscription and Role Collections
#------------------------------------------------------------------------------------#
module "build_process_automation" {
  source = "./modules/build_process_automation"

  subaccount_id = btp_subaccount.sa_build.id

  process_automation_admins       = var.process_automation_admins
  process_automation_developers   = var.process_automation_developers
  process_automation_participants = var.process_automation_participants
}
*/


#------------------------------------------------------------------------------------#
# Set up Entitlements, service subscription and Role Collections
#------------------------------------------------------------------------------------#
# A module is a container for multiple resources that are used together
module "integrationsuite-trial" {
  #Path to the local file directory 
  source = "./modules/integration_suite"

  subaccount_id = btp_subaccount.sa_build.id

  integration_suite_admins = var.integration_suite_admins
}
