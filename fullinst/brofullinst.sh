#This is for the complete installation of bro, all its dependencies and support to connect it to timemachine, whose install
#is located in the tminst.sh file
#Created by Theory5 with a ton of help from April and Ziggy


#run updates without asking
apt-get -y update
apt-get -y upgrade

#install dependencies that bro may need

apt-get -y install install libpcap0.8 libpcap0.8-dev libpcap-dev autogen gcc make libxml2-dev libgnutls-dev libcurl4-gnutls-dev libnl-dev build-essential autopoint xsltproc w3c-dtd-xhtml python-dev libxen-dev uuid-dev libdevmapper-dev libgnutls-dev libpciaccess-dev libxml2-dev pm-utils ebtables libcap2-bin libcap-dev cmake make g++ flex bison libssl-dev python-dev swig zlib1g-dev libmagic-dev autoconf curl bind9 sendmail gawk

#install libgeoIP databases/packages

apt-get -y install libgeoip-dev libgeoip1

apt-get -y install git git-core

git clone --recursive git://git.bro.org/bro bro

cd bro

./configure

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

#add bro cronjob to ensure bro is always running

crontab -e > brocron
echo "0-59/5 * * * * $PREFIX/bin/broctl cron" >> brocron
crontab brocron
rm brocron
