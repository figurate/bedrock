node default {

  include nginx

  class { 'nginx_amplify':
    api_key => lookup('nginx_amplify::api_key'),
  }
}
