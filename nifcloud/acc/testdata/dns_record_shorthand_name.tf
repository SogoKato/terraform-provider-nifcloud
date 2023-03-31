resource "nifcloud_dns_record" "basic" {
  zone_id        = nifcloud_dns_zone.basic.id
  name           = var.dns_record_shorthand_name
  type           = "A"
  ttl            = 60
  record         = "192.0.2.1"
  comment        = "tfacc-memo"
}

resource "nifcloud_dns_zone" "basic" {
  name    = var.dns_zone_name
  comment = "tfacc-memo"
}

variable "dns_record_shorthand_name" {
    description = "test dns record (shorthand)"
    type        = string
}

variable "dns_zone_name" {
    description = "test dns zone"
    type        = string
}
