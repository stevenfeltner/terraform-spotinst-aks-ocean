variable "name" {
  type = string
  description = "(Required) The Ocean cluster name."
}
variable "controller_cluster_id" {
  type = string
  description = "(Required) A unique identifier used for connecting the Ocean SaaS platform and the Kubernetes cluster. Typically, the cluster name is used as its identifier."
}
variable "aks_name" {
  type = string
  description = "(Required) The AKS cluster name."
}
variable "acd_identifier" {
  type = string
  description = "(Required) The AKS identifier. A valid identifier should be formatted as acd-nnnnnnnn and previously used identifiers cannot be reused."
}
variable "aks_resource_group_name" {
  type = string
  description = "(Required) Name of the Azure Resource Group where the AKS cluster is located."
}
variable "ssh_public_key" {
  type = string
  description = "(Required) SSH public key for admin access to Linux VMs."
}
variable "user_name" {
  type = string
  description = "(Optional) Username for admin access to VMs."
}
variable "resource_group_name" {
  type = string
  default = null
  description = "(Optional) Name of the Azure Resource Group into which VMs will be launched. Cannot be updated."
}
variable "custom_data" {
  type = string
  default = null
  description = "(Optional) Must contain a valid Base64 encoded string."
}
## managed_service_identity ##
variable "managed_service_identity" {
  type = object({
    resource_group_name = string
    name = string
  })
  default = null
  description = "List of Managed Service Identity objects."
}
variable "tags" {
  type = list(object({
    key = string
    value = string
  }))
  default = null
  description = "Additional Tags to be added to resources"
}

### network ###
variable "virtual_network_name" {
  type = string
  default = null
  description = "(Optional) Virtual network."
}
### network_interface ###
variable "subnet_name" {
  type = string
  default = null
  description = "Subnet name."
}
variable "assign_public_ip" {
  type = bool
  default = null
  description = "Assign public IP."
}
variable "is_primary" {
  type = bool
  default = null
  description = "Defines whether the network interface is primary or not."
}
### additional_ip_config ###
variable "additional_ip_config_name" {
  type = string
  default = null
  description = "Additional configuration of network interface. The name fields between all the additional_ip_config must be unique."
}
variable "additional_ip_config_private_ip_version" {
  type = string
  default = null
  description = "(Optional, Default: IPv4) Supported values: IPv4, IPv6"
}

### Extension ###
variable "extension_api_version" {
  type = string
  default = null
  description = "(Optional) API version of the extension."
}
variable "extension_minor_version_auto_upgrade" {
  type = string
  default = null
  description = "(Optional) Toggles whether auto upgrades are allowed."
}
variable "extension_name" {
  type = string
  default = null
  description = "(Optional) Extension name."
}
variable "extension_publisher" {
  type = string
  default = null
  description = "(Optional) Extension publisher."
}
variable "extension_type" {
  type = string
  default = null
  description = "(Optional) Extension type."
}

### os_disk ###
variable "size_gb" {
  type = number
  default = ""
}
variable "type" {
  type = string
  default = ""
}

### Load Balancer ###
variable "backend_pool_name" {
  type = string
  default = null
  description = "(Optional) Names of the Backend Pools to register the Cluster VMs to. Each Backend Pool is a separate load balancer."
}
variable "load_balancer_sku" {
  type = string
  default = null
  description = "(Optional) Supported values: Standard, Basic."
}
variable "load_balancer_name" {
  type = string
  default = null
  description = "(Optional) Name of the Load Balancer."
}
variable "load_balancer_type" {
  type = string
  default = null
  description = "(Optional) The type of load balancer. Supported value: loadBalancer"
}

### Image ###
variable "publisher" {
  type = string
  default = ""
  description = "(Optional) Image publisher."
}
variable "offer" {
  type = string
  default = ""
  description = "(Optional) Image name."
}
variable "sku" {
  type = string
  default = ""
  description = "(Optional) Image Stock Keeping Unit (which is the specific version of the image)."
}
variable "image_version" {
  type = string
  default = ""
  description = "(Optional, Default: latest) Image version."
}

### vm_sizes ###
variable "whitelist" {
  type = list(string)
  default = null
  description = "(Optional) VM types allowed in the Ocean cluster."
}

### strategy ###
variable "fallback_to_ondemand" {
  type = bool
  default = null
  description = "(Optional) If no spot instance markets are available, enable Ocean to launch on-demand instances instead."
}
variable "spot_percentage" {
  type = string
  default = null
  description = "(Optional) Percentage of Spot VMs to maintain."
}

### health ###
variable "grace_period" {
  type = number
  default = null
  description = "(Optional, Default: 600) The amount of time to wait, in seconds, from the moment the instance has launched before monitoring its health checks."
}

### autoscaler ###
variable "autoscale_is_enabled" {
  type = bool
  default = null
  description = "(Optional) Enable the Ocean Kubernetes Autoscaler."
}
variable "max_scale_down_percentage" {
  type = number
  default = null
  description = "(Optional) Would represent the maximum % to scale-down."
}
### resource_limits ###
variable "max_vcpu" {
  type = number
  default = null
  description = "(Optional) The maximum cpu in vCpu units that can be allocated to the cluster."
}
variable "max_memory_gib" {
  type = number
  default = null
  description = "(Optional) The maximum memory in GiB units that can be allocated to the cluster."
}
### autoscale_headroom ###
variable "autoscale_headroom_automatic_is_enabled" {
  type = bool
  default = null
  description = "(Optional) Enable automatic headroom. When set to true, Ocean configures and optimizes headroom automatically."
}
variable "autoscale_headroom_automatic_percentage" {
  type = number
  default = null
  description = "(Optional) Optionally set a number between 0-100 to control the percentage of total cluster resources dedicated to headroom. Relevant when isEnabled is toggled on."
}