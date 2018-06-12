# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|

  config.vm.define "tor1" do |tor1|
    config.vm.provider "virtualbox" do |tor1|
      tor1.name = "tor1"
    end
    tor1.vm.box = "minimal/xenial64"
        tor1.vm.network :forwarded_port, guest: 22, host: 12200, id: 'ssh'
        tor1.vm.network "private_network", virtualbox__intnet: "tor1_spine1", auto_config: false
        tor1.vm.network "private_network", virtualbox__intnet: "tor1_spine2", auto_config: false
        tor1.vm.network "private_network", virtualbox__intnet: "tor1_hv", auto_config: false
        tor1.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 172.16.0.0/31 dev enp0s8
          sudo ip addr add 172.16.0.2/31 dev enp0s9
          sudo ip addr add 192.168.0.1/26 dev enp0s10
          sudo ip link set enp0s8 up
          sudo ip link set enp0s9 up
          sudo ip link set enp0s10 up
	  sudo sysctl net.ipv4.ip_forward=1 
          sudo apt-get update
          sudo apt-get -y install software-properties-common
          sudo apt-get -y install python-software-properties
          sudo apt-add-repository -y ppa:cz.nic-labs/bird
          sudo apt-get update
          sudo apt-get -y install bird
          sudo apt-get -y install lldpd
          sudo service lldpd start
	  sudo cp /vagrant/tor1-bird.conf /etc/bird/bird.conf
	  sudo service bird restart
        SHELL
        tor1.vm.hostname = "tor1"
  end

  config.vm.define "tor2" do |tor2|
    config.vm.provider "virtualbox" do |tor2|
      tor2.name = "tor2"
    end
    tor2.vm.box = "minimal/xenial64"
        tor2.vm.network :forwarded_port, guest: 22, host: 12201, id: 'ssh'
        tor2.vm.network "private_network", virtualbox__intnet: "tor2_spine1", auto_config: false
        tor2.vm.network "private_network", virtualbox__intnet: "tor2_spine2", auto_config: false
        tor2.vm.network "private_network", virtualbox__intnet: "tor2_hv", auto_config: false
        tor2.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 172.16.0.4/31 dev enp0s8
          sudo ip addr add 172.16.0.6/31 dev enp0s9
          sudo ip addr add 192.168.0.65/26 dev enp0s10
          sudo ip link set enp0s8 up
          sudo ip link set enp0s9 up
          sudo ip link set enp0s10 up
	  sudo sysctl net.ipv4.ip_forward=1 
          sudo apt-get update
          sudo apt-get -y install software-properties-common
          sudo apt-get -y install python-software-properties
          sudo apt-add-repository -y ppa:cz.nic-labs/bird
          sudo apt-get update
          sudo apt-get -y install bird
          sudo apt-get -y install lldpd
          sudo service lldpd start
	  sudo cp /vagrant/tor2-bird.conf /etc/bird/bird.conf
	  sudo service bird restart
        SHELL
        tor2.vm.hostname = "tor2"
  end

  config.vm.define "spine1" do |spine1|
    config.vm.provider "virtualbox" do |spine1|
      spine1.name = "spine1"
    end
    spine1.vm.box = "minimal/xenial64"
        spine1.vm.network :forwarded_port, guest: 22, host: 12202, id: 'ssh'
        spine1.vm.network "private_network", virtualbox__intnet: "tor1_spine1", auto_config: false
        spine1.vm.network "private_network", virtualbox__intnet: "tor2_spine1", auto_config: false
        spine1.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 172.16.0.1/31 dev enp0s8
          sudo ip addr add 172.16.0.5/31 dev enp0s9
          sudo ip link set enp0s8 up
          sudo ip link set enp0s9 up
	  sudo sysctl net.ipv4.ip_forward=1 
          sudo apt-get update
          sudo apt-get -y install software-properties-common
          sudo apt-get -y install python-software-properties
          sudo apt-add-repository -y ppa:cz.nic-labs/bird
          sudo apt-get update
          sudo apt-get -y install bird
          sudo apt-get -y install lldpd
          sudo service lldpd start
	  sudo cp /vagrant/spine1-bird.conf /etc/bird/bird.conf
	  sudo service bird restart
        SHELL
        spine1.vm.hostname = "spine1"
  end

  config.vm.define "spine2" do |spine2|
    config.vm.provider "virtualbox" do |spine2|
      spine2.name = "spine2"
    end
    spine2.vm.box = "minimal/xenial64"
        spine2.vm.network :forwarded_port, guest: 22, host: 12203, id: 'ssh'
        spine2.vm.network "private_network", virtualbox__intnet: "tor1_spine2", auto_config: false
        spine2.vm.network "private_network", virtualbox__intnet: "tor2_spine2", auto_config: false
        spine2.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 172.16.0.3/31 dev enp0s8
          sudo ip addr add 172.16.0.7/31 dev enp0s9
          sudo ip link set enp0s8 up
          sudo ip link set enp0s9 up
	  sudo sysctl net.ipv4.ip_forward=1 
          sudo apt-get update
          sudo apt-get -y install software-properties-common
          sudo apt-get -y install python-software-properties
          sudo apt-add-repository -y ppa:cz.nic-labs/bird
          sudo apt-get update
          sudo apt-get -y install bird
          sudo apt-get -y install lldpd
          sudo service lldpd start
	  sudo cp /vagrant/spine2-bird.conf /etc/bird/bird.conf
	  sudo service bird restart
        SHELL
        spine2.vm.hostname = "spine2"
  end

  config.vm.define "hv1" do |hv1|
    config.vm.provider "virtualbox" do |hv1|
      hv1.name = "hv1"
    end
    hv1.vm.box = "minimal/xenial64"
        hv1.vm.network :forwarded_port, guest: 22, host: 12204, id: 'ssh'
        hv1.vm.network "private_network", virtualbox__intnet: "tor1_hv", auto_config: false
        hv1.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 192.168.0.2/26 dev enp0s8
          sudo ip link set enp0s8 up
	  sudo ip route add 192.168.0.0/16 via 192.168.0.1
	  sudo ip route add 172.16.0.0/19 via 192.168.0.1
          sudo apt-get update
          sudo apt-get -y install traceroute
          sudo apt-get -y install lldpd
          sudo service lldpd start
        SHELL
        hv1.vm.hostname = "hv1"
  end

  config.vm.define "hv2" do |hv2|
    config.vm.provider "virtualbox" do |hv2|
      hv2.name = "hv2"
    end
    hv2.vm.box = "minimal/xenial64"
        hv2.vm.network :forwarded_port, guest: 22, host: 12205, id: 'ssh'
        hv2.vm.network "private_network", virtualbox__intnet: "tor1_hv", auto_config: false
        hv2.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 192.168.0.3/26 dev enp0s8
          sudo ip link set enp0s8 up
	  sudo ip route add 192.168.0.0/16 via 192.168.0.1
	  sudo ip route add 172.16.0.0/19 via 192.168.0.1
          sudo apt-get update
          sudo apt-get -y install traceroute
          sudo apt-get -y install lldpd
          sudo service lldpd start
        SHELL
        hv2.vm.hostname = "hv2"
  end

  config.vm.define "hv3" do |hv3|
    config.vm.provider "virtualbox" do |hv3|
      hv3.name = "hv3"
    end
    hv3.vm.box = "minimal/xenial64"
        hv3.vm.network :forwarded_port, guest: 22, host: 12206, id: 'ssh'
        hv3.vm.network "private_network", virtualbox__intnet: "tor2_hv", auto_config: false
        hv3.vm.provision "shell", inline: <<-SHELL
          sudo ip addr add 192.168.0.66/26 dev enp0s8
          sudo ip link set enp0s8 up
	  sudo ip route add 192.168.0.0/16 via 192.168.0.65
	  sudo ip route add 172.16.0.0/19 via 192.168.0.65
          sudo apt-get update
          sudo apt-get -y install traceroute
          sudo apt-get -y install lldpd
          sudo service lldpd start
        SHELL
        hv3.vm.hostname = "hv3"
  end

end
  
