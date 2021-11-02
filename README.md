# terraform-spotinst-aks-ocean
Spotinst Terraform Module to integrate existing AKS with Ocean

## Prerequisites

Installation of the Ocean controller is required by this resource. You can accomplish this by using the [spotinst/ocean-controller](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst) module. The kubernetes provider will need to be initilaized before calling the ocean-controller module as follows:

```hcl
module "aks-ocean" {
  source  = "stevenfeltner/aks-ocean/spotinst"
  ...
}

## initialize kubernetes provider ##
provider "kubernetes" {
  ...
}
##################

module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  # Credentials.
  spotinst_token   = "redacted"
  spotinst_account = "redacted"

  # Configuration.
  cluster_identifier = "cluster name"
}
```

~> You must configure the same `cluster_identifier` both for the Ocean controller and for the `spotinst_ocean_aks` resource. The `aks-ocean` module will use the cluster name as the identifier. Ensure this is also used in the controller config

## Usage
```hcl
module "aks-ocean" {
  source = "stevenfeltner/aks-ocean/spotinst"

  # Spot.io Credentials
  spotinst_token              = "redacted"
  spotinst_account            = "redacted"

  # Configuration
  name                        = "Sample-AKS"
  acd_identifier              = "acd-12345678"
  aks_name                    = "AKS-Cluster"
  aks_resource_group_name     = "AKS-Cluster-RG"
  ssh_public_key              = "ssh-rsa [... redacted ...]"
  user_name                   = "azure-user"
  custom_data                 = "redacted"
  
  # Additional Tags
  tags = [{key = "CreatedBy", value = "Terraform"}]
}
```

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.30.0 |

## Modules
* `aks-ocean` - Creates Ocean Cluster
* `ocean-controller` - Create and installs Spot Ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst/latest)
* `aks-ocean-virtual-node-group` - (Optional) Add custom virtual node groups

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](CONTRIBUTING.md).