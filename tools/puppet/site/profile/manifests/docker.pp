class profile::docker(
  $version,
) {

  class { '::docker':
    version => $version,
  }
}