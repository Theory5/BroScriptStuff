#!/bin/bash

#script for installing Time Machine

#run updates... will not ask for permission
apt-get -y update


#install anything that may be a dependency.

apt-get install -y libpcap0.8 libpcap0.8-dev libpcap-dev > outputinst.txt

#install git if not already

apt-get install -y git-core git &>> outputinst.txt

#download latest source (and pray they haven't altered the folder structure) and put into "timemachine"

git clone https://github.com/bro/time-machine.git timemachine

cd timemachine

echo "This install assumes that you've installed bro to the local prefix /usr/local/bro and not some other, weird one."

./configure --with-pcaps=* --with-broccoli=/usr/local/bro &>> outputinst.txt

make &>> outputinst.txt

make install &>> outputinst.txt

#ensure time machine can write to /usr/local/var/tm

mkdir -p /usr/local/var/tm &>> outputinst.txt

chmod 0666 /usr/local/var/tm &>> outputinst.txt

echo "Time Machine config found here: /usr/local/etc/timemachine.cfg"

#install attached scripts to bro for communication purposes

cd ../

cd tmint

mkdir -p /usr/local/bro/share/bro/base/frameworks/tmint/

cp /tmint/main.bro /usr/local/bro/share/bro/base/frameworks/tmint/main.bro

cp /tmint/__load__.bro /usr/local/bro/share/bro/base/frameworks/tmint/__load__.bro

echo "@load base/frameworks/tmint/" >> /usr/local/bro/share/bro/site/local.bro
