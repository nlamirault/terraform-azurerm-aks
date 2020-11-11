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

#############################################################################
# Provider

#############################################################################
# Resource Group

variable resource_group_name {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable subscription_id {
  type        = string
  description = "Specifies the ID of the subscription"
}

#############################################################################
# Networking

variable subnet_name {
  type        = string
  description = "Name of the Subnet"
}

variable virtual_network_name {
  type        = string
  description = "Name of the Virtual Network this Subnet is located within"
}

#variable subnet_name_services {
#  type = string
#  description = "Name of the Subnet for Services"
#}

#variable subnet_name_pods {
#  type = string
#  description = "Name of the Subnet for Pods"
#}

#############################################################################
# Kubernetes cluster

variable cluster_name {
  type        = string
  description = "Name of the AKS cluster"
}

variable location {
  type        = string
  description = "The Azure Region where the Resource Group should exist."
}

variable kubernetes_version {
  type        = string
  description = "The AKS Kubernetes version"
}

#variable admin_username {
#  type = string
#  default = "admin"
#}

#variable ssh_public_key {
#  type = string
#}

variable rbac {
  type        = bool
  default     = true
  description = "Enable RBAC on the Kubernetes API"
}

variable pod_security_policy {
  type        = bool
  description = "Enable PodSecurityPolicy the Kubernetes API"
}

#variable client_id {
#  description = "The Client ID for the Service Principal"
#}

#variable client_secret {
#  description = "The Client Secret for the Service Principal."
#}

variable tags {
  type = map
  default = {
    made-by = "terraform"
  }
}

#############################################################################
# Network profile

variable network_plugin {
  type        = string
  description = "The CNI network plugin to use (only azure, or kubenet)"
  default     = "kubenet"
}

variable network_policy {
  description = "The network polcy for the CNI. Only used when network_plugin is set to azure. Supported values: calico, azure"
  default     = null
}

variable pod_cidr {
  type        = string
  description = "The CIDR for the pod network"
}

variable service_cidr {
  type        = string
  description = "The CIDR for kubernetes services"
}

variable dns_service_ip {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery"
}

variable docker_bridge_cidr {
  type        = string
  description = " IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
}

#############################################################################
# Addon profile

variable http_application_routing {
  type = bool
}

variable kube_dashboard {
  type = bool
}

variable aci_connector_linux {
  type = bool
}

variable azure_policy {
  type = bool
}

#############################################################################
# Default node pool

variable node_count {
  type        = number
  description = "The default node pool instance count"
}

variable node_vm_size {
  type        = string
  description = "The Azure VM instance type"
  # default     = "Standard_D2s_v3"
}

variable os_disk_size_gb {
  default     = 50
  description = "Default node pool disk size"
}

variable enable_auto_scaling {
  type        = bool
  description = "Enable autoscaling on the default node pool"
}

variable node_min_count {
  default     = 1
  description = "Default node pool intial count (used with autoscaling)"
}

variable node_max_count {
  default     = 10
  description = "Default node pool max count (use with autoscaling)"
}

variable node_max_pods {
  default     = 110
  description = "Total amount of pods allowed per node"
}

variable node_availability_zones {
  default     = [1, 2, 3]
  description = "The availability zones to place the node pool instances"
}

variable node_taints {
  type        = list(string)
  description = "Taints for default pool nodes"
}

#############################################################################
# Auto-scaler profile

variable "balance_similar_node_groups" {
  type    = bool
  default = false
}

variable "max_graceful_termination_sec" {
  type    = string
  default = "600"
}

variable "scale_down_delay_after_add" {
  type    = string
  default = "10m"
}

variable "scale_down_delay_after_delete" {
  type    = string
  default = "10s"
}

variable "scale_down_delay_after_failure" {
  type    = string
  default = "10m"
}

variable "scan_interval" {
  type    = string
  default = "10s"
}

variable "scale_down_unneeded" {
  type    = string
  default = "10m"
}

variable "scale_down_unready" {
  type    = string
  default = "10m"
}

variable "scale_down_utilization_threshold" {
  type    = string
  default = "0.5"
}

#############################################################################
# Addons node pool

variable node_pools {
  description = "Addons node pools"
  type = list(object({
    name                = string
    vm_size             = string
    os_disk_size_gb     = number
    enable_auto_scaling = bool
    node_count          = number
    min_count           = number
    max_count           = number
    max_pods            = number
    node_taints         = list(string)
  }))
  default = []
}
