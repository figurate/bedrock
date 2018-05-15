class profile::ntp(
  $enable,
  $servers,
) {

  class { 'ntp':
    service_enable => $enable,
    servers => $servers,
  }
}
