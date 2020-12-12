class profile::ufw(
  $allow,
  $limit,
  $deny_outgoing,
) {

  class { 'ufw':
    allow => $allow,
    limit => $limit,
    deny_outgoing => $deny_outgoing,
  }
}
