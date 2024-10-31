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
# }
locals {
  subaccount_domain = lower(replace("${random_uuid.uuid.result}", "_", "-"))
}
