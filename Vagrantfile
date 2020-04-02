# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "agmazalu/debbox"

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", ip: "192.168.168.192"

  config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => [ "dmode=777", "fmode=666" ] }

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.provision "shell", path: "bootstrap.sh"
end
