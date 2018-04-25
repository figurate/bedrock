node default {

  class { 'docker': }

  class { 'rancher::server': }
}
