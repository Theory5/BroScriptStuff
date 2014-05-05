!#bin/bash/

#script for installing Time Machine

#run updates... will not ask for permission
apt-get -y update
apt-get -y dist-upgrade

#install anything that may be a dependency.

apt-get install libpcap0.8 libpcap0.8-dev libpcap-dev > outputinst.txt

#install git if not already

apt-get -y install git-core git >> outputinst.txt

#download latest source (and pray they haven't altered the folder structure) and put into "timemachine"

git https://github.com/bro/time-machine.git timemachine

cd timemachine

echo "This install assumes that you've installed bro to the local prefix /usr/local/bro and not some other, weird one."

./configure --with-pcaps=* --with-broccoli=/usr/local/bro >> outputinst.txt

make > outputinst.txt

make install > outputinst.txt

echo "Add configuration file. Assumes your main adapter is eth0. Change /usr/local/etc/timemachine.cfg"

