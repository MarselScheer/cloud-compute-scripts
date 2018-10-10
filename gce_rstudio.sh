#!/bin/bash

# Installs an RStudio Server on an Debian-9-Stretch

sudo apt-get install -y gdebi-core 
wget https://download2.rstudio.org/rstudio-server-stretch-1.1.456-amd64.deb
sudo gdebi -n rstudio-server-stretch-1.1.456-amd64.deb

#sudo echo 'server-app-armor-enabled=0' >> /etc/rstudio/rserver.conf
#sudo rstudio-server verify-installation
#sudo rstudio-server start

sudo mkdir /usr/local/gce
sudo chown m:m /usr/local/gce

sudo useradd -m gce
sudo passwd gce

echo "Login to RStudio with username -gce-"
