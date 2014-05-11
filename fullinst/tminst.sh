#!/bin/bash

#script for installing Time Machine

#run updates... will not ask for permission
apt-get -y update


#install anything that may be a dependency.

apt-get install -y libpcap0.8 libpcap0.8-dev libpcap-dev libreadline6-dev &>  tminst.log

#install git if not already

apt-get install -y git-core git &>>  tminst.log

#download latest source (and pray they haven't altered the folder structure) and put into "timemachine"

git clone --recursive https://github.com/bro/time-machine.git timemachine

cd timemachine

echo "This install assumes that you've installed bro to the local prefix /usr/local/bro and not some other, weird one."

./configure --with-pcaps=* --with-broccoli=/usr/local/bro &>> ../tminst.log

make &>>  ../tminst.log

make install &>>  ../tminst.log

#ensure time machine can write to /usr/local/var/tm

mkdir -p /usr/local/var/tm &>>  ../tminst.log

chmod 0666 /usr/local/var/tm &>>  ../tminst.log

echo "Time Machine config found here: /usr/local/etc/timemachine.cfg"

#install attached scripts to bro for communication purposes

cd ../tminst

mkdir -p /usr/local/bro/share/bro/base/frameworks/tminst/ &>>  ../tminst.log

cp /timinst/main.bro /usr/local/bro/share/bro/base/frameworks/timinst/main.bro &>>  ../tminst.log

cp /timinst/__load__.bro /usr/local/bro/share/bro/base/frameworks/tminst/__load__.bro &>>  ../tminst.log

echo "@load base/frameworks/tminst/" >> /usr/local/bro/share/bro/site/local.bro &>>  ../tminst.log

# preface with a question/prompt?
#apt-get -y remove git git-core &>>  ../tminst.log

echo "a log file of this installation can be found here tminst.log"
