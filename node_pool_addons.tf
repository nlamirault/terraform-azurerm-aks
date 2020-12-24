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

resource "azurerm_kubernetes_cluster_node_pool" "ops" {
  count = length(var.node_pools)

  name                  = var.node_pools[count.index].name
  orchestrator_version  = var.kubernetes_version
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vnet_subnet_id        = data.azurerm_subnet.nodes.id
  availability_zones    = var.node_availability_zones
  os_type               = "Linux"
  vm_size               = var.node_pools[count.index].vm_size
  os_disk_size_gb       = var.node_pools[count.index].os_disk_size_gb
  enable_auto_scaling   = var.node_pools[count.index].enable_auto_scaling
  node_count            = var.node_pools[count.index].node_count
  min_count             = var.node_pools[count.index].min_count
  max_count             = var.node_pools[count.index].max_count
  max_pods              = var.node_pools[count.index].max_pods
  node_taints           = var.node_pools[count.index].node_taints
  node_labels           = var.node_pools[count.index].node_labels
  tags                  = var.tags
  enable_node_public_ip = false
  # priority              = var.node_pools[count.index].priority # See https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster_node_pool.html#priority
}
