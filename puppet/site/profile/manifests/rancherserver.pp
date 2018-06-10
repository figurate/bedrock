class profile::rancherserver {

  include profile::docker
  include rancher::server
}
