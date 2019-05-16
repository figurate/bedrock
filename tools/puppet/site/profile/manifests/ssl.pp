class profile::ssl(
  $email,
  $country,
  $organization,
  $directory,
) {

  ssl::self_signed_certificate { $::fqdn:
    common_name      => $::fqdn,
    email_address    => $email,
    country          => $country,
    organization     => $organization,
    days             => '30',
    directory        => $directory,
    subject_alt_name => "DNS:*.${::fqdn}, DNS:${::fqdn}",
  }
}
