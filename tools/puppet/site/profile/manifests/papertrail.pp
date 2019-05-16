class profile::papertrail(
  $host,
  $port,
  $files,
) {

  class { 'papertrail':
    destination_host => $host,
    destination_port => 0 + $port,
    files => $files,
  }
}
