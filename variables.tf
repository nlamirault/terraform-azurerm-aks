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

#############################################################################
# Provider

#############################################################################
# Resource Group

variable "resource_group_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}


#############################################################################
# Networking

variable "subnet_name" {
  type        = string
  description = "Name of the Subnet"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the Virtual Network this Subnet is located within"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "The Name which should be used for the networking Resource Group"
}

#############################################################################
# Active Directory

# variable "aad_group_name" {
#   description = "Name of the Azure AD group for cluster-admin access"
#   type        = string
# }

#############################################################################
# Kubernetes cluster

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The AKS Kubernetes version"
}

variable "private_cluster_enabled" {
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  type        = bool
  default     = false
}

#variable admin_username {
#  type = string
#  default = "admin"
#}

#variable ssh_public_key {
#  type = string
#}

# variable rbac {
#   type        = bool
#   default     = true
#   description = "Enable RBAC on the Kubernetes API"
# }

variable "pod_security_policy" {
  type        = bool
  description = "Enable PodSecurityPolicy the Kubernetes API"
}

#variable client_id {
#  description = "The Client ID for the Service Principal"
#}

#variable client_secret {
#  description = "The Client Secret for the Service Principal."
#}

variable "tags" {
  description = "A mapping of tags to assign to the Node Pool"
  type        = map(any)
  default = {
    "made-by" = "terraform"
  }
}

variable "node_labels" {
  description = "A map of Kubernetes labels which should be applied to nodes in the Default Node Pool"
  type        = map(any)
  default = {
    "service" = "kubernetes"
  }
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  description = "The IP ranges to whitelist for incoming traffic to the masters."
}

#############################################################################
# Network profile

variable "network_plugin" {
  type        = string
  description = "The CNI network plugin to use (only azure, or kubenet)"
  default     = "kubenet"
}

variable "network_policy" {
  type        = string
  description = "The network polcy for the CNI. Only used when network_plugin is set to azure. Supported values: calico, azure"
}

variable "pod_cidr" {
  type        = string
  description = "The CIDR for the pod network"
}

variable "service_cidr" {
  type        = string
  description = "The CIDR for kubernetes services"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery"
}

variable "docker_bridge_cidr" {
  type        = string
  description = " IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
}

#############################################################################
# Addon profile

variable "http_application_routing" {
  type        = bool
  description = "Is HTTP Application Routing Enabled"
}

variable "kube_dashboard" {
  type        = bool
  description = "Is the Kubernetes Dashboard enabled"
}

variable "aci_connector_linux" {
  type        = bool
  description = "Is the virtual node addon enabled"
}

variable "azure_policy" {
  description = "Is the Azure Policy for Kubernetes Add On enabled"
  type        = bool
}

variable "enable_open_service_mesh" {
  description = "Enable Open Service Mesh Addon."
  type        = bool
  default     = false
}

variable "enable_ingress_application_gateway" {
  description = "If true will enable Application Gateway ingress controller to this Kubernetes Cluster"
  type        = bool
  default     = false
}

variable "ingress_application_gateway_subnet_id" {
  description = "The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster"
  type        = string
  default     = null
}

#############################################################################
# Maintenance

variable "enable_maintenance_window" {
  description = "Enable maintenance for AKS cluster"
  type        = bool
  default     = false
}

variable "maintenance_allowed" {
  description = "Days and hours when maintenance is allowed"
  type = list(object({
    day   = string
    hours = list(string)
  }))
  default = []
}

variable "maintenance_not_allowed" {
  description = "Days and hours when maintenance is not allowed"
  type = list(object({
    end   = string
    start = string
  }))
  default = []
}

#############################################################################
# Default node pool

variable "node_count" {
  type        = number
  description = "The default node pool instance count"
}

variable "node_vm_size" {
  type        = string
  description = "The Azure VM instance type"
  # default     = "Standard_D2s_v3"
}

variable "os_disk_size_gb" {
  default     = 50
  type        = number
  description = "Default node pool disk size"
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Enable autoscaling on the default node pool"
}

variable "node_min_count" {
  default     = 1
  type        = number
  description = "Default node pool intial count (used with autoscaling)"
}

variable "node_max_count" {
  default     = 10
  type        = number
  description = "Default node pool max count (use with autoscaling)"
}

variable "node_max_pods" {
  default     = 110
  type        = number
  description = "Total amount of pods allowed per node"
}

variable "node_availability_zones" {
  default     = [1, 2, 3]
  type        = list(number)
  description = "The availability zones to place the node pool instances"
}

variable "node_taints" {
  type        = list(string)
  description = "Taints for default pool nodes"
}

#############################################################################
# Auto-scaler profile

variable "balance_similar_node_groups" {
  description = "Detect similar node groups and balance the number of nodes between them"
  type        = bool
  default     = false
}

variable "max_graceful_termination_sec" {
  description = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node"
  type        = string
  default     = "600"
}

variable "scale_down_delay_after_add" {
  description = "How long after the scale up of AKS nodes the scale down evaluation resumes"
  type        = string
  default     = "10m"
}

variable "scale_down_delay_after_delete" {
  type        = string
  description = "How long after node deletion that scale down evaluation resumes"
  default     = "10s"
}

variable "scale_down_delay_after_failure" {
  description = "How long after scale down failure that scale down evaluation resumes"
  type        = string
  default     = "10m"
}

variable "scan_interval" {
  description = "How often the AKS Cluster should be re-evaluated for scale up/down"
  type        = string
  default     = "10s"
}

variable "scale_down_unneeded" {
  description = "How long a node should be unneeded before it is eligible for scale down"
  type        = string
  default     = "10m"
}

variable "scale_down_unready" {
  description = "How long an unready node should be unneeded before it is eligible for scale down"
  type        = string
  default     = "10m"
}

variable "scale_down_utilization_threshold" {
  description = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down"
  type        = string
  default     = "0.5"
}

#############################################################################
# Addons node pool

variable "node_pools" {
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
    node_labels         = map(string)
  }))
  default = []
}
