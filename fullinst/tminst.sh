#!/bin/bash

#script for installing Time Machine

#run updates... will not ask for permission
apt-get -y update


#install anything that may be a dependency.

apt-get install -y libpcap0.8 libpcap0.8-dev libpcap-dev &> ~/var/log/tminst.txt

#install git if not already

apt-get install -y git-core git &>> ~/var/log/tminst.txt

#download latest source (and pray they haven't altered the folder structure) and put into "timemachine"

git clone --recursive https://github.com/bro/time-machine.git timemachine

cd timemachine

echo "This install assumes that you've installed bro to the local prefix /usr/local/bro and not some other, weird one."

./configure --with-pcaps=* --with-broccoli=/usr/local/bro &>> ~/var/log/tminst.txt

make &>> ~/var/log/tminst.txt

make install &>> ~/var/log/tminst.txt

#ensure time machine can write to /usr/local/var/tm

mkdir -p /usr/local/var/tm &>> ~/var/log/tminst.txt

chmod 0666 /usr/local/var/tm &>> ~/var/log/tminst.txt

echo "Time Machine config found here: /usr/local/etc/timemachine.cfg"

#install attached scripts to bro for communication purposes

cd ../

cd tminst

mkdir -p /usr/local/bro/share/bro/base/frameworks/tminst/ &>> ~/var/log/tminst.txt

cp /timinst/main.bro /usr/local/bro/share/bro/base/frameworks/timinst/main.bro &>> ~/var/log/tminst.txt

cp /timinst/__load__.bro /usr/local/bro/share/bro/base/frameworks/tminst/__load__.bro &>> ~/var/log/tminst.txt

echo "@load base/frameworks/tminst/" >> /usr/local/bro/share/bro/site/local.bro &>> ~/var/log/tminst.txt

# preface with a question/prompt?
#apt-get -y remove git git-core &>> ~/var/log/tminst.txt

echo "a log file of this installation can be found here /var/log/tminst.txt"
