data "digitalocean_domain" alias_domain {
  name = var.alias_domain
}

resource "digitalocean_spaces_bucket" bucket {
  name   = var.bucket_name
  region = var.do_region
  acl    = "public-read"
}

resource "digitalocean_cdn" cdn {
  origin = digitalocean_spaces_bucket.bucket.bucket_domain_name
}

resource "digitalocean_record" record {
  count  = length(var.aliases)
  domain = data.digitalocean_domain.alias_domain.name
  name   = var.aliases[count.index]
  type   = "CNAME"
  ttl    = var.record_ttl
  value  = "${digitalocean_cdn.cdn.endpoint}."
}
