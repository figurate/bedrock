data "digitalocean_domain" apex_domain {
  count = var.fqdn != "" ? 1 : 0
  name  = local.apex_domain
}

resource "digitalocean_spaces_bucket" bucket {
  name   = var.bucket_name
  region = var.do_region
  acl    = "public-read"
}

resource "digitalocean_record" record {
  count  = var.fqdn != "" ? 1 : 0
  domain = data.digitalocean_domain.apex_domain[0].name
  name   = local.record_name
  type   = "CNAME"
  ttl    = var.record_ttl
  value  = "${var.bucket_name}.${var.do_region}.cdn.digitaloceanspaces.com."
}

resource "digitalocean_certificate" "cert" {
  count   = var.fqdn != "" ? 1 : 0
  name    = var.fqdn
  type    = "lets_encrypt"
  domains = [var.fqdn]
}

resource "digitalocean_cdn" cdn {
  origin         = digitalocean_spaces_bucket.bucket.bucket_domain_name
  custom_domain  = var.fqdn != "" ? digitalocean_record.record[0].fqdn : null
  certificate_id = var.fqdn != "" ? digitalocean_certificate.cert[0].id : null
}
