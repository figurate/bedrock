class profile::reverseproxy(
  $hosts,
  $upstreams,
  $vhosts,
) {

  include profile::nginx
  include profile::ssl
  include profile::letsencrypt
  include www_static

  $hosts.each |String $host_name, $values| {
    host { $host_name:
      * => $values,
    }
  }

  $upstreams.each |String $upstream_name, $values| {
    nginx::resource::upstream { $upstream_name:
      * => $values,
    }
  }

  $vhosts.each |String $vhost_name, $values| {
    nginx::resource::server { $vhost_name:
      * => $values,
    }
  }

  letsencrypt::certonly { 'generate_cert':
    domains => $vhosts.keys,
    plugin => 'nginx',
    manage_cron => true,
    cron_before_command => 'service nginx stop',
    cron_success_command => '/bin/systemctl reload nginx.service',
    suppress_cron_output => true,
    require => Package['python-certbot-nginx']
  }
}
