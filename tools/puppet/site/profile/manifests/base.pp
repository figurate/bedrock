class profile::base {

  include profile::ufw
  include profile::acct
  include profile::ntp
  include profile::swap
  # include profile::rsyslog
  include profile::papertrail

  file { '/etc/localtime':
    ensure => 'link',
    target => '/usr/share/zoneinfo/Australia/Melbourne',
  }
}
