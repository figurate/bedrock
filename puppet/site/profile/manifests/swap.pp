class profile::swap(
  $enable = false,
) {

  $ensure = $enable? {
    true => present,
    default  => absent,
  }

  swap_file::files { 'default':
    ensure => $ensure,
  }
}
