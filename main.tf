resource "spotinst_ocean_aks" "cluster" {
  name                          = var.name
  controller_cluster_id         = var.controller_cluster_id
  acd_identifier                = var.acd_identifier
  aks_name                      = var.aks_name
  aks_resource_group_name       = var.resource_group_name
  ssh_public_key                = var.ssh_public_key
  user_name                     = var.user_name
  resource_group_name           = var.resource_group_name
  custom_data                   = var.custom_data

  dynamic "managed_service_identity" {
    for_each = var.managed_service_identity != null ? [var.managed_service_identity] : []
    content {
      resource_group_name         = managed_service_identity.value.resource_group_name
      name                        = managed_service_identity.value.name
    }
  }

  # Additional Tags
  dynamic tags {
    for_each = var.tags == null ? [] : var.tags
    content {
      key = tags.value["key"]
      value = tags.value["value"]
    }
  }

  network {
    virtual_network_name        = var.virtual_network_name
    resource_group_name         = var.resource_group_name
    network_interface {
      subnet_name               = var.subnet_name
      assign_public_ip          = var.assign_public_ip
      is_primary                = var.is_primary
      additional_ip_config {
        name                    = var.additional_ip_config_name
        private_ip_version      = var.additional_ip_config_private_ip_version
      }
    }
  }

  extension {
    api_version                 = var.extension_api_version
    minor_version_auto_upgrade  = var.extension_minor_version_auto_upgrade
    name                        = var.extension_name
    publisher                   = var.extension_publisher
    type                        = var.extension_type
  }

  os_disk {
    size_gb       = var.size_gb
    type          = var.type
  }

  load_balancer {
    backend_pool_names          = var.backend_pool_name
    load_balancer_sku           = var.load_balancer_sku
    name                        = var.load_balancer_name
    resource_group_name         = var.resource_group_name
    type                        = var.load_balancer_type
  }

  image {
    marketplace {
      publisher   = var.publisher
      offer       = var.offer
      sku         = var.sku
      version     = var.image_version
    }
  }

  vm_sizes {
    whitelist     = var.whitelist
  }

  strategy {
    fallback_to_ondemand        = var.fallback_to_ondemand
    spot_percentage             = var.spot_percentage
  }

  health {
    grace_period                = var.grace_period
  }

  autoscaler {
    autoscale_is_enabled        = var.autoscale_is_enabled
    autoscale_down {
      max_scale_down_percentage = var.max_scale_down_percentage
    }
    resource_limits {
      max_vcpu                  = var.max_vcpu
      max_memory_gib            = var.max_memory_gib
    }

    autoscale_headroom {
      automatic {
        is_enabled              = var.autoscale_headroom_automatic_is_enabled
        percentage              = var.autoscale_headroom_automatic_percentage
      }
    }
  }
}