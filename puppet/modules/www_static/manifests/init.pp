class www_static {

  exec { 'mkdir -p /var/www/html/error':
    path => "/bin"
  }
  ->
  file { '404.html':
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    path    => '/var/www/html/error/404.html',
    source  => 'puppet:///modules/www_static/www/html/error/404.html',
  }

  exec { 'mkdir -p /var/www/images':
    path => "/bin"
  }
  ->
  file { 'railway-bridge.jpeg':
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    path    => '/var/www/images/railway-bridge.jpeg',
    source  => 'puppet:///modules/www_static/www/images/railway-bridge.jpeg',
  }
}