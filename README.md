# terraform-azure-kubernetes

Terraform module which configure a Kubernetes cluster on AWS

## Versions

Use Terraform `0.13` and Terraform Azure Provider `2.3+`.

## Usage

```hcl
module "aks" {
  source  = "nlamirault/aks/azure"
  version = "X.Y.Z"

  cluster_name = var.cluster_name
  location = var.location

  resource_group_name  = var.resource_group_name
  subscription_id      = var.subscription_id
  subnet_name          = var.subnet_name
  virtual_network_name = var.virtual_network_name

  kubernetes_version  = var.kubernetes_version
  pod_security_policy = var.pod_security_policy
  rbac                = var.rbac

  # Default node pool
  node_count               = var.node_count
  node_vm_size             = var.node_vm_size
  os_disk_size_gb          = var.os_disk_size_gb
  node_availability_zones  = var.node_availability_zones
  enable_auto_scaling      = var.enable_auto_scaling
  node_min_count           = var.node_min_count
  node_max_count           = var.node_max_count
  node_max_pods            = var.node_max_pods
  node_taints              = var.node_taints

  # Network profile
  network_plugin     = var.network_plugin
  network_policy     = var.network_policy
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr
  dns_service_ip     = var.dns_service_ip
  docker_bridge_cidr = var.docker_bridge_cidr

  # Addon profile
  aci_connector_linux = var.aci_connector_linux
  azure_policy = var.azure_policy
  http_application_routing = var.http_application_routing
  kube_dashboard = var.kube_dashboard

  # Autoscaler profile
  balance_similar_node_groups      = var.balance_similar_node_groups
  max_graceful_termination_sec     = var.max_graceful_termination_sec
  scan_interval                    = var.scan_interval
  scale_down_delay_after_add       = var.scale_down_delay_after_add
  scale_down_delay_after_delete    = var.scale_down_delay_after_delete
  scale_down_delay_after_failure   = var.scale_down_delay_after_failure
  scale_down_unneeded              = var.scale_down_unneeded
  scale_down_unready               = var.scale_down_unready
  scale_down_utilization_threshold = var.scale_down_utilization_threshold

  tags        = var.tags
  node_labels = var.node_labels

  # Addons node pool
  node_pools = var.node_pools
}


}
```

```hcl
############################################################################
# Provider

resource_group_name = "myproject-dev"

#############################################################################
# Networking

virtual_network_name = "myproject-dev"
subnet_name = "myproject-dev-aks-nodes"

############################################################################
# AKS

cluster_name = "myproject-dev-aks"

location = "francecentral"

kubernetes_version = "1.18.8"

rbac = true
pod_security_policy  = false

tags = {
    "env" = "dev"
    "project" = "myproject"
    "service" = "kubernetes"
    "made-by" = "terraform"
}

#############################################################################
# Default node pool

node_count = 2
node_vm_size = "Standard_D2s_v3"
os_disk_size_gb = 50
enable_auto_scaling = true
node_min_count = 1
node_max_count = 4
node_max_pods = 110
node_availability_zones = [1, 2, 3]
node_taints = []
node_labels = {
    "service" = "kubernetes"
    "env"     = "dev"
    "project" = "myproject"
}

#############################################################################
# Network profile

network_plugin = "kubenet"
network_policy = "azure"
pod_cidr       = "10.0.16.0/20"
service_cidr   = "10.0.32.0/20"
dns_service_ip = "10.0.32.10"
docker_bridge_cidr = "172.0.0.1/8"

#############################################################################
# Addon profile

http_application_routing = false
kube_dashboard = false
aci_connector_linux = false
azure_policy = false

#############################################################################
# Auto-scaler profile

#############################################################################
# Addons node pool

node_pools = []
```

This module creates :

* a Kubernetes cluster

## Documentation

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 2.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aci\_connector\_linux | n/a | `bool` | n/a | yes |
| azure\_policy | n/a | `bool` | n/a | yes |
| balance\_similar\_node\_groups | n/a | `bool` | `false` | no |
| cluster\_name | Name of the AKS cluster | `string` | n/a | yes |
| dns\_service\_ip | IP address within the Kubernetes service address range that will be used by cluster service discovery | `string` | n/a | yes |
| docker\_bridge\_cidr | IP address (in CIDR notation) used as the Docker bridge IP address on nodes | `string` | n/a | yes |
| enable\_auto\_scaling | Enable autoscaling on the default node pool | `bool` | n/a | yes |
| http\_application\_routing | n/a | `bool` | n/a | yes |
| kube\_dashboard | n/a | `bool` | n/a | yes |
| kubernetes\_version | The AKS Kubernetes version | `string` | n/a | yes |
| location | The Azure Region where the Resource Group should exist. | `string` | n/a | yes |
| max\_graceful\_termination\_sec | n/a | `string` | `"600"` | no |
| network\_plugin | The CNI network plugin to use (only azure, or kubenet) | `string` | `"kubenet"` | no |
| network\_policy | The network polcy for the CNI. Only used when network\_plugin is set to azure. Supported values: calico, azure | `any` | n/a | yes |
| node\_availability\_zones | The availability zones to place the node pool instances | `list` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| node\_count | The default node pool instance count | `number` | n/a | yes |
| node\_max\_count | Default node pool max count (use with autoscaling) | `number` | `10` | no |
| node\_max\_pods | Total amount of pods allowed per node | `number` | `110` | no |
| node\_min\_count | Default node pool intial count (used with autoscaling) | `number` | `1` | no |
| node\_pools | Addons node pools | <pre>list(object({<br>    name                = string<br>    vm_size             = string<br>    os_disk_size_gb     = number<br>    enable_auto_scaling = bool<br>    node_count          = number<br>    min_count           = number<br>    max_count           = number<br>    max_pods            = number<br>    node_taints         = list(string)<br>  }))</pre> | `[]` | no |
| node\_taints | Taints for default pool nodes | `list(string)` | n/a | yes |
| node\_vm\_size | The Azure VM instance type | `string` | n/a | yes |
| os\_disk\_size\_gb | Default node pool disk size | `number` | `50` | no |
| pod\_cidr | The CIDR for the pod network | `string` | n/a | yes |
| pod\_security\_policy | Enable PodSecurityPolicy the Kubernetes API | `bool` | n/a | yes |
| rbac | Enable RBAC on the Kubernetes API | `bool` | `true` | no |
| resource\_group\_name | The Name which should be used for this Resource Group | `string` | n/a | yes |
| scale\_down\_delay\_after\_add | n/a | `string` | `"10m"` | no |
| scale\_down\_delay\_after\_delete | n/a | `string` | `"10s"` | no |
| scale\_down\_delay\_after\_failure | n/a | `string` | `"10m"` | no |
| scale\_down\_unneeded | n/a | `string` | `"10m"` | no |
| scale\_down\_unready | n/a | `string` | `"10m"` | no |
| scale\_down\_utilization\_threshold | n/a | `string` | `"0.5"` | no |
| scan\_interval | n/a | `string` | `"10s"` | no |
| service\_cidr | The CIDR for kubernetes services | `string` | n/a | yes |
| subnet\_name | Name of the Subnet | `string` | n/a | yes |
| subscription\_id | Specifies the ID of the subscription | `string` | n/a | yes |
| tags | n/a | `map` | <pre>{<br>  "made-by": "terraform"<br>}</pre> | no |
| virtual\_network\_name | Name of the Virtual Network this Subnet is located within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aks\_clustername | n/a |
| aks\_kube\_config | n/a |
| pod\_cidr | n/a |
| service\_cidr | n/a |

