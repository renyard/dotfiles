# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/xenial64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provider :virtualbox do |vb|
      vb.memory = 2048
  end

  # Synced folders.
  config.vm.synced_folder "./", "/home/ubuntu/dotfiles"
  config.vm.synced_folder "../workspace", "/home/ubuntu/workspace"

  # Provisioning.
  config.vm.provision :shell, :path => "provision.sh"
  config.vm.provision :shell, :privileged => false, :inline => "cd ~/dotfiles && ./install.sh"

end
