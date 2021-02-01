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

data "azurerm_subscription" "main" {
}

data "azurerm_resource_group" "k8s" {
  name = var.resource_group_name
}

data "azurerm_subnet" "nodes" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.k8s.name
  virtual_network_name = var.virtual_network_name
}

#data "azuread_group" "aks" {
#  name = var.aad_group_name
#}

data "azurerm_user_assigned_identity" "k8s" {
  name                = format("%s-agentpool", azurerm_kubernetes_cluster.k8s.name)
  resource_group_name = azurerm_kubernetes_cluster.k8s.node_resource_group
}
