class nginx_amplify(
  $api_key = '',
) {

  package {'python':
    ensure => installed,
  }
  
  exec {'install_agent':
    path => '/bin:/usr/bin:/sbin:/usr/sbin',
    command => "curl -sS -L -O \
https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
API_KEY='$api_key' sh ./install.sh",
  }
}