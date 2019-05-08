class profile::acct(
  $enable,
) {

  class { 'acct':
    enable => $enable,
  }
}
