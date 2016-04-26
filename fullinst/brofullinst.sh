#!/bin/bash
#This is for the complete installation of bro, all its dependencies and support to connect it to timemachine, whose install
#is located in the tminst.sh file
#Created by Theory5 with a ton of help from April and Ziggy


#run updates without asking
apt-get -y update
apt-get -y upgrade

#install dependencies that bro may need

apt-get -y install libpcap0.8 libpcap0.8-dev libpcap-dev autogen gcc libxml2-dev; apt-get -y install libgnutls-dev libcurl4-gnutls-dev libnl-dev build-essential; apt-get -y install autopoint xsltproc w3c-dtd-xhtml python-dev libxen-dev uuid-dev; apt-get -y install libdevmapper-dev libgnutls-dev libpciaccess-dev libxml2-dev pm-utils; apt-get -y install ebtables libcap2-bin libcap-dev cmake make g++ flex bison; apt-get -y install libssl-dev python-dev swig zlib1g-dev libmagic-dev autoconf; apt-get -y install curl bind9 sendmail gawk  CMake

#install libgeoIP databases/packages

apt-get -y install libgeoip-dev libgeoip1

apt-get -y install git git-core

#fixes "NO MTA" issue in ubuntu
apt-get -y install postfix

#add CAF, was missing

git clone --recursive https://github.com/actor-framework/actor-framework.git actor-framework

cd actor-framework

./configure

make

#remove any previous attempts at installation

make clean 

make install

echo "CAF installed (hopefully)"

cd ../

# install for PF RING, for managing multiple instances of packet monitoring sensors evenly with loadbalancing

# instructions taken from http://www.ntop.org/get-started/download/#PF_RING may be modified slightly

#move to home dir (stupid version, need to rewrite) 

cd 

git clone --recursive https://github.com/ntop/PF_RING.git PF_RING

cd ../userland

make

#return to beginning

cd lib

./configure --prefix=/opt/pfring
make install

cd ../libpcap
./configure --prefix=/opt/pfring
make install

cd ../tcpdump-*
./configure --prefix=/opt/pfring
make install

cd ../../kernel

make install

insmod ./pf_ring.ko

modprobe pf_ring enable_tx_capture=0 min_num_slots=32768

cd

git clone --recursive git://git.bro.org/bro bro

cd bro

./configure --with-pcap=/opt/pfring

make

#removes any attempts at previous installations

make clean

make install

#install some programs in the aux/bro-aux dir
make install-aux

echo "Default Bro Path is /usr/local/bro"

#install configuration files


#append broctl command path to /etc/environment

echo "export PATH=/usr/local/bro/bin:$PATH" &>> /etc/environment



echo "It is suggested that you add this cronjob to your crontab for housekeeping and ensuring bro will always be running. 0-59/5 * * * * $PREFIX/bin/broctl cron"
