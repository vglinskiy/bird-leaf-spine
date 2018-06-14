# -*- mode: ruby -*-
# vi: set ft=ruby :
BOX_BASE = "minimal/xenial64"

# Creating 2 TORs
Vagrant.configure(2) do |config|
 (1..2).each do |i|
    config.vm.define "tor#{i}" do |node|
      config.vm.provider "virtualbox" do |node|
        node.name = "tor#{i}"
      end
      node.vm.box = BOX_BASE
        node.vm.network "private_network", virtualbox__intnet: "tor#{i}_spine1", auto_config: false
        node.vm.network "private_network", virtualbox__intnet: "tor#{i}_spine2", auto_config: false
        node.vm.network "private_network", virtualbox__intnet: "tor#{i}_hv", auto_config: false
        node.vm.provision "shell", path: "provisioner.sh", args: #{i} 
        node.vm.hostname = "tor#{i}"
      end
    end

# Creating 2 spines
 (1..2).each do |i|
    config.vm.define "spine#{i}" do |node|
      config.vm.provider "virtualbox" do |node|
        node.name = "spine#{i}"
      end
      node.vm.box = BOX_BASE
        node.vm.network "private_network", virtualbox__intnet: "tor1_spine#{i}", auto_config: false
        node.vm.network "private_network", virtualbox__intnet: "tor2_spine#{i}", auto_config: false
        node.vm.provision "shell", path: "provisioner.sh", args: #{i} 
        node.vm.hostname = "spine#{i}"
      end
    end

# Creating 3 servers: 1st and 2nd connected to tor1 and 3d to tor2
 (1..3).each do |i|
    config.vm.define "hv#{i}" do |node|
      config.vm.provider "virtualbox" do |node|
        node.name = "hv#{i}"
      end
      node.vm.box = BOX_BASE
       if i < 3
        node.vm.network "private_network", virtualbox__intnet: "tor1_hv", auto_config: false
       else
        node.vm.network "private_network", virtualbox__intnet: "tor2_hv", auto_config: false
       end
        node.vm.provision "shell", path: "provisioner.sh", args: #{i} 
        node.vm.hostname = "hv#{i}"
      end
    end

end
  
