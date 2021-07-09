# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
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

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = var.cluster_location
  resource_group_name = azurerm_resource_group.aks.name

  dns_prefix = var.cluster_name

  kubernetes_version = var.kubernetes_version

  # private_cluster_enabled = true

  #linux_profile {
  #  admin_username = var.admin_username
  #  ssh_key {
  #    key_data = file(var.ssh_public_key)
  #  }
  #}

  default_node_pool {
    name                  = "core"
    orchestrator_version  = var.kubernetes_version
    node_count            = var.node_count
    vm_size               = var.node_vm_size
    os_disk_size_gb       = var.os_disk_size_gb
    vnet_subnet_id        = data.azurerm_subnet.nodes.id
    type                  = "VirtualMachineScaleSets"
    availability_zones    = var.node_availability_zones
    enable_auto_scaling   = var.enable_auto_scaling
    min_count             = var.node_min_count
    max_count             = var.node_max_count
    max_pods              = var.node_max_pods
    node_taints           = var.node_taints
    node_labels           = var.node_labels
    enable_node_public_ip = false
  }

  enable_pod_security_policy = var.pod_security_policy

  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_plugin == "kubenet" ? null : var.network_policy
    pod_cidr           = var.network_policy == "kubenet" ? var.pod_cidr : null
    docker_bridge_cidr = var.docker_bridge_cidr
    dns_service_ip     = var.dns_service_ip
    service_cidr       = var.service_cidr # data.azurerm_subnet.services.address_prefixes[0]
    load_balancer_sku  = "standard"
  }

  addon_profile {
    aci_connector_linux {
      enabled = var.aci_connector_linux
    }

    azure_policy {
      enabled = var.azure_policy
    }

    http_application_routing {
      enabled = var.http_application_routing
    }

    kube_dashboard {
      enabled = var.kube_dashboard
    }

    oms_agent {
      enabled = false
    }
  }

  auto_scaler_profile {
    balance_similar_node_groups      = var.balance_similar_node_groups
    max_graceful_termination_sec     = var.max_graceful_termination_sec
    scan_interval                    = var.scan_interval
    scale_down_delay_after_add       = var.scale_down_delay_after_add
    scale_down_delay_after_delete    = var.scale_down_delay_after_delete
    scale_down_delay_after_failure   = var.scale_down_delay_after_failure
    scale_down_unneeded              = var.scale_down_unneeded
    scale_down_unready               = var.scale_down_unready
    scale_down_utilization_threshold = var.scale_down_utilization_threshold
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true

    #azure_active_directory {
    #  managed = true
    #  admin_group_object_ids = [
    #    data.azuread_group.aks.id
    #  ]
    #}
  }

  # service_principal {
  #   client_id     = azuread_application.k8s.application_id
  #   client_secret = azuread_service_principal_password.k8s.value
  # }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      # Since autoscaling is enabled, let's ignore changes to the node count.
      default_node_pool[0].node_count,
      service_principal
    ]
  }
}
