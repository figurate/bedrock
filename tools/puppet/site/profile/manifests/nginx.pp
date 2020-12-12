class profile::nginx(
  $proxy_cache_path,
  $log_format = {},
  $amplify_api_key,
) {

  class { 'nginx':
    proxy_cache_path => $proxy_cache_path,
    log_format => $log_format,
  }

  class { 'nginx_amplify':
    api_key => $amplify_api_key,
  }
}
