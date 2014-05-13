#This is for the complete installation of bro, all its dependencies and support to connect it to timemachine, whose install
#is located in the tminst.sh file
#Created by Theory5 with a ton of help from April and Ziggy


#run updates without asking
apt-get -y update
apt-get -y upgrade

apt-get -y install git git-core

git clone --recursive git://git.bro.org/bro bro

