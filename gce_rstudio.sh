#!/bin/bash

# Installs an RStudio Server on an Debian-9-Stretch

# check www.rstudio.com/products/rstudio/download-server/ for newer versions

rstudio=rstudio-server-stretch-1.1.463-amd64.deb

sudo apt-get install -y gdebi-core 
wget https://download2.rstudio.org/$rstudio
sudo gdebi -n $rstudio

#sudo echo 'server-app-armor-enabled=0' >> /etc/rstudio/rserver.conf
#sudo rstudio-server verify-installation
#sudo rstudio-server start

sudo mkdir /usr/local/gce
sudo chown m:m /usr/local/gce

sudo useradd -m gce
sudo passwd gce

echo "Login to RStudio with username -gce-"
