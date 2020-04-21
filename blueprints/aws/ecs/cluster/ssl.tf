/*
 * Provision a self-signed certificate and import to AWS ACM.
 */
resource "tls_private_key" "ssl_certificate" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ssl_certificate" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.ssl_certificate.private_key_pem
  validity_period_hours = 2160 // 6 months
  subject {
    common_name  = format("*.%s", local.default_namespace)
    organization = ""
    country      = ""
  }
}

resource "aws_acm_certificate" "ssl_certificate" {
  private_key      = tls_private_key.ssl_certificate.private_key_pem
  certificate_body = tls_self_signed_cert.ssl_certificate.cert_pem
}
