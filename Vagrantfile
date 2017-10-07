# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "ubuntu/trusty64"
  config.vm.box = "debian/jessie64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 3724, host: 3724 # auth server port
  config.vm.network "forwarded_port", guest: 8085, host: 8085 # world server port
  config.vm.network "forwarded_port", guest: 3306, host: 3306 # mysql database

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # This folder is shared with the VM
  config.vm.synced_folder "./vagrant", "/vagrant"

  # Enable provisioning with a shell script.
  config.vm.provision "shell", inline: <<-SHELL
    sudo chmod +x /vagrant/setup.sh
    sudo /vagrant/setup.sh
  SHELL

  config.vm.provider "virtualbox" do |v|
    v.name = "NostalriusTBC"
    v.cpus = 2 # Increase this if you have enough CPUs :)
    # Min recommended memory : 400 + 200*cpu MB
    v.memory = 2048
  end
end
