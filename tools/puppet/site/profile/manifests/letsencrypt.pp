class profile::letsencrypt(
  $email,
  $server,
) {

  apt::ppa { 'ppa:certbot/certbot': }
  ->
  package { 'python-certbot-nginx':
    ensure => installed,
    require => Class['apt::update'],
  }

  class { ::letsencrypt:
    manage_install => false,
    manage_config => false,
    config => {
      email => $email,
      server => $server,
    },
  }
}
