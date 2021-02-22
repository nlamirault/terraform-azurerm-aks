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

locals {
  service_name            = format("%s-aks", var.resource_group_name)
  container_registry_name = replace(local.service_name, "-", "")
  # ad_server    = format("%s-server", var.cluster_name)
  # ad_client    = format("%s-client", var.cluster_name)
  # ad_admins    = format("%s-cluster-admins", var.cluster_name)
}
