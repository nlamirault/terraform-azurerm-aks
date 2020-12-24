# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

data "azurerm_user_assigned_identity" "k8s" {
  name                = format("%s-agentpool", azurerm_kubernetes_cluster.k8s.name)
  resource_group_name = azurerm_kubernetes_cluster.k8s.node_resource_group
}

# resource "azuread_application" "k8s" {
#   name = var.cluster_name
# }

# resource "azuread_service_principal" "k8s" {
#   application_id = azuread_application.k8s.application_id
# }

# resource "random_string" "k8s" {
#   length  = 16
#   special = true

#   keepers = {
#     service_principal = azuread_service_principal.k8s.id
#   }
# }

# resource "azuread_service_principal_password" "k8s" {
#   service_principal_id = azuread_service_principal.k8s.id
#   value                = random_string.k8s.result
#   end_date             = timeadd(timestamp(), "8760h")

#   # This stops be 'end_date' changing on each run and causing a new password to be set
#   # to get the date to change here you would have to manually taint this resource...
#   lifecycle {
#     ignore_changes = [end_date]
#   }
# }

# # https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal
# resource "azurerm_role_definition" "k8s" {
#   name        = var.cluster_name
#   scope       = data.azurerm_subscription.main.id
#   description = "Created by Terraform"

#   permissions {
#     actions = [
#       "Microsoft.Compute/virtualMachines/read",
#       "Microsoft.Compute/virtualMachines/write",
#       "Microsoft.Compute/disks/write",
#       "Microsoft.Compute/disks/read",
#       "Microsoft.Network/loadBalancers/write",
#       "Microsoft.Network/loadBalancers/read",
#       "Microsoft.Network/routeTables/read",
#       "Microsoft.Network/routeTables/routes/read",
#       "Microsoft.Network/routeTables/routes/write",
#       "Microsoft.Network/routeTables/routes/delete",
#       "Microsoft.Network/virtualNetworks/subnets/join/action",
#       "Microsoft.Storage/storageAccounts/fileServices/*/read",
#       "Microsoft.ContainerRegistry/registries/read",
#       "Microsoft.ContainerRegistry/registries/pull/read",
#       "Microsoft.Network/publicIPAddresses/read",
#       "Microsoft.Network/publicIPAddresses/write",
#     ]

#     not_actions = [
#       "Microsoft.Compute/virtualMachines/*/action",
#       "Microsoft.Compute/virtualMachines/extensions/*",
#     ]
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.main.id,
#   ]
# }

# resource "azurerm_role_assignment" "k8s_control_plane" {
#   scope              = data.azurerm_subscription.main.id
#   role_definition_id = azurerm_role_definition.k8s.id
#   principal_id       = azuread_service_principal.k8s.id
#   #role_definition_id = trimsuffix(azurerm_role_definition.k8s.idrole_definition_id = trimsuffix(azurerm_role_definition.k8s.id, "|${azurerm_role_definition.k8s.scope}")
# }

# resource "azurerm_role_assignment" "k8s_network" {
#   scope                = data.azurerm_subscription.main.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azuread_service_principal.k8s.id
# }
