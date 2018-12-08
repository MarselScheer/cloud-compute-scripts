#!/bin/bash

# Installs an RStudio Server on an Debian-9-Stretch

# check www.rstudio.com/products/rstudio/download-server/ for newer versions

RSTUDIO=rstudio-server-stretch-1.1.463-amd64.deb

sudo apt-get install -y gdebi-core 
wget https://download2.rstudio.org/$RSTUDIO
sudo gdebi -n $RSTUDIO

#sudo echo 'server-app-armor-enabled=0' >> /etc/rstudio/rserver.conf
#sudo rstudio-server verify-installation
#sudo rstudio-server start

sudo mkdir /usr/local/gce
sudo chown m:m /usr/local/gce

sudo useradd -m gce
sudo passwd gce


source ./GIT_CONFIG
echo ""
echo "Set git user and email to for user -gce-:"
echo $GIT_NAME
echo $GIT_EMAIL
sudo su -c "git config --global user.name $GIT_NAME" gce
sudo su -c "git config --global user.email $GIT_EMAIL" gce


echo ""
echo "Login to RStudio with username -gce-"
echo ""
