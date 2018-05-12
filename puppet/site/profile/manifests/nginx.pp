class profile::nginx(
  $amplify_api_key,
) {

  include nginx

  class { 'nginx_amplify':
    api_key => $amplify_api_key,
  }
}
