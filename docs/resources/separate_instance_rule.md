---
page_title: "NIFCLOUD: nifcloud_separate_instance_rule"
subcategory: "Computing"
description: |-
  Provides a separate instance rule resource.
---

# nifcloud_separate_instance_rule

Provides a separate instance rule resource.

## Example Usage

```hcl
terraform {
  required_providers {
    nifcloud = {
      source = "nifcloud/nifcloud"
    }
  }
}

provider "nifcloud" {
  region = "jp-east-1"
}

resource "nifcloud_separate_instance_rule" "web" {
  instance_id        = [nifcloud_instance.web1.instance_id, nifcloud_instance.web2.instance_id]
  availability_zone  = "east-11"
  description        = "test"   
  name               = "test001"
}

resource "nifcloud_security_group" "web" {
  group_name        = "webfw"
  availability_zone = "east-11"
}

resource "nifcloud_key_pair" "web" {
  key_name   = "webkey"
  public_key = "c3NoLXJzYSBBQUFBQjNOemFDMXljMkVBQUFBREFRQUJBQUFCZ1FEVjJpcjBTWjUvWTBCRm9DK1pRMVU4SUpISWZTWkc2QUljbHFCclhqaTNYZ2h3eG9PYzgxUkZmTW55aVB3OGRsakVodlFTcnl0eXpZNkhkVDZZZVR1OWhYWE9sckw3SlExbDVWbEZmT3VsZGlWQi92YTVzL2ZNQlR2SG50aHh4a3hiTm9BYkphQ1lxQVJucStHemU2clNGOEFHOC9DckUwckxuK2tlK1Jkb0d6Mk9uRlc0MDZId01uZVBkRm1QSzFKYjhUZVZMNzUyN3pUaUs0anV2SXU2TlQ2MU96aDh4OHZzRkhzNm52NWRRR0FCdm8rMjUycDJMdUlwczlnNDIydmg1VGhpQ0FPTmRXdjQvZHZrVWg4NDN6a1VRL0tISGNhWkpjcG1zdXNPNUhnbzdKLzk4VVVBU0NPVGgwSVZxZjFtQXdxRkZLVjFkTEw2YnJES2lTTFMwQVkwWUdkMHMvN3lGMTdIK2o1VDVPNjd2Z0RqbTR3K041MFhvUVIwbU5BY0t3UVM0NHhkWkRxallXTzVuc0ZVOWZZY3RsejQ2Qk5xTk51My9GOWJVbFhBM0dkY2FHRmw5elZZQjVwWTdqOW9jbFQ1VWNXdkY1UXByYWFRZGhxVEkxZjFRclRLRkN6Vm1Dc1ROWkZBZU1VMVcwTWFUU1QreVljK0NNc2xSa009IFNDSjAwMDg3QHVidW50dQo="
}

resource "nifcloud_instance" "web1" {
  instance_id       = "testrun001"
  availability_zone = "east-11"
  image_id          = data.nifcloud_image.ubuntu.id
  key_name          = nifcloud_key_pair.web.key_name
  security_group    = nifcloud_security_group.web.group_name
  instance_type     = "mini"
  accounting_type   = "2"

  network_interface {
    network_id = "net-COMMON_GLOBAL"
  }

  network_interface {
    network_id = "net-COMMON_PRIVATE"
  }
}

resource "nifcloud_instance" "web2" {
  instance_id       = "testrun002"
  availability_zone = "east-11"
  image_id          = data.nifcloud_image.ubuntu.id
  key_name          = nifcloud_key_pair.web.key_name
  security_group    = nifcloud_security_group.web.group_name
  instance_type     = "mini"
  accounting_type   = "2"

  network_interface {
    network_id = "net-COMMON_GLOBAL"
  }

  network_interface {
    network_id = "net-COMMON_PRIVATE"
  }
}

data "nifcloud_image" "ubuntu" {
  image_name = "Ubuntu Server 20.04 LTS"
}
```

## Argument Reference

The following arguments are supported:

* `availability_zone` - (Required) The availability zone.
* `name` - (Required) The separate instance rule name.
* `description` - (Optional) The separate instance rule description.
* `instance_id` - (Optional) The instance name. Cannot be specified with `instance_unique_id`.
* `instance_unique_id` - (Optional) The unique ID of instance. Cannot be specified with `instance_id`. This argument is deprecated.

## Import

nifcloud_separate_instance_rule can be imported using the `parameter corresponding to id`, e.g.

```
$ terraform import nifcloud_separate_instance_rule.example foo
```
