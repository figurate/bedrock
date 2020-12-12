class profile::rancheragent(
  $hosts,
  $registration_url,
) {

  include profile::docker

  $hosts.each |String $host_name, $values| {
    host { $host_name:
      * => $values,
    }
  }

  class { '::rancher':
    registration_url => $registration_url,
  }
}
