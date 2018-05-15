class profile::base {

  include profile::ufw
  include profile::ntp

  file { '/etc/localtime':
    ensure => 'link',
    target => '/usr/share/zoneinfo/Australia/Melbourne',
  }
}
