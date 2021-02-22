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

output "aks_kube_config" {
  value       = azurerm_kubernetes_cluster.k8s.kube_config_raw
  description = "AKS kubeconfig"
}

output "aks_clustername" {
  value       = azurerm_kubernetes_cluster.k8s.name
  description = "AKS cluster name"
}

output "aks_service_principal_id" {
  value       = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
  description = "ID of the user assigned identity"
}
