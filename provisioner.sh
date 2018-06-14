export tor1_enp0s8_IP="172.16.0.0/31"
export tor1_enp0s9_IP="172.16.0.2/31"
export tor1_enp0s10_IP="192.168.0.1/26"

export tor2_enp0s8_IP="172.16.0.4/31"
export tor2_enp0s9_IP="172.16.0.6/31"
export tor2_enp0s10_IP="192.168.0.65/26"

export spine1_enp0s8_IP="172.16.0.1/31"
export spine1_enp0s9_IP="172.16.0.5/31"

export spine2_enp0s8_IP="172.16.0.3/31"
export spine2_enp0s9_IP="172.16.0.7/31"

export hv1_enp0s8_IP="192.168.0.2/26"
export hv1_gw_IP="192.168.0.1"

export hv2_enp0s8_IP="192.168.0.3/26"
export hv2_gw_IP="192.168.0.1"

export hv3_enp0s8_IP="192.168.0.66/26"
export hv3_gw_IP="192.168.0.65"

function configure_switches() {
  declare ip_addr=${1}_enp0s8_IP
  sudo ip addr add ${!ip_addr} dev enp0s8
  sudo ip link set enp0s8 up

  declare ip_addr=${1}_enp0s9_IP
  sudo ip addr add ${!ip_addr} dev enp0s9
  sudo ip link set enp0s9 up

  if  [[ $1 =~ tor ]] 
  then
    declare ip_addr=${1}_enp0s10_IP
    sudo ip addr add ${!ip_addr} dev enp0s10
    sudo ip link set enp0s10 up
  fi

  sudo sysctl net.ipv4.ip_forward=1
  sudo apt-get update
  sudo apt-get -y install software-properties-common
  sudo apt-get -y install python-software-properties
  sudo apt-add-repository -y ppa:cz.nic-labs/bird
  sudo apt-get update
  sudo apt-get -y install bird
  sudo apt-get -y install lldpd
  sudo service lldpd start
  sudo cp /vagrant/$1-bird.conf /etc/bird/bird.conf
  sudo service bird restart
}

function configure_servers() {
  declare ip_addr=${1}_enp0s8_IP
  sudo ip addr add ${!ip_addr} dev enp0s8
  sudo ip link set enp0s8 up

  declare ip_gw=${1}_gw_IP
  sudo ip route add 192.168.0.0/24 via ${!ip_gw}
  sudo ip route add 172.16.0.0/26 via ${!ip_gw}
  sudo apt-get update
  sudo apt-get -y install traceroute
  sudo apt-get -y install lldpd
  sudo service lldpd start
}

if  [[ $1 =~ hv ]] 
then
  configure_servers $1
else
  configure_switches $1
fi
