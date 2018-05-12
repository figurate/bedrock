class profile::ufw(
  $allow,
  $limit,
) {

  class { 'ufw':
    allow => $allow,
    limit => $limit,
  }
}
