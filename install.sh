#!/bin/bash
cd /root
cat <<EOF> /etc/yum.repos.d/xrdp.repo
[xrdp]

name=xrdp

baseurl=http://li.nux.ro/download/nux/dextop/el7/x86_64/

enabled=1

gpgcheck=0
EOF 
yum install xrdp -y
yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y
systemctl set-default graphical.target
yum update -y && yum install git wget bzip2 vim gcc-c++ ntp epel-release nodejs cmake screen tmux -y
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
wget https://dl.google.com/go/go1.14.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> /etc/profile  
echo 'export PATH=$PATH:$GOROOT/bin' >> /etc/profile  
echo 'export GOPATH=/root/go' >> /etc/profile
echo 'export PATH=$PATH:$GOPATH/bin' >> /etc/profile
source /etc/profile
git clone https://github.com/ethereum/go-ethereum.git  
cd go-ethereum  
make all
echo 'export PATH=$PATH:/opt/go-ethereum/build/bin' >> /etc/profile
source /etc/profile
geth --cache=4096 --maxpeers=50 --syncmode=light  --rpcapi eth,web3 --rpc
