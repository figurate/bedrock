Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.provision :shell, path: "orchestration/scripts/ubuntu/bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--audio", "none"]
  end
end
