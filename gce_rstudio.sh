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

sudo useradd -m gce
sudo passwd gce
sudo echo "export EDITOR=emacs" >> /home/gce/.bashrc

sudo su -c "mkdir /home/gce/projects" gce
echo "-------------------------------------"
echo "create a projects-folder for gce. Use rsync for downloading:"
echo "rsync --dry-run --exclude 'foo' --exclude 'bar' -avrzhe ssh m@<IP>:/home/gce/projects /<DEST>"
echo ""
echo "in order to upload to /home/gce/projects add a public key to /home/gce/.ssh/authorized_keys and then"
echo "rsync --dry-run --exclude 'foo' --exclude 'bar' -avrzhe ssh /<SRC> gce@<IP>:/home/gce/projects/ "


source ./GIT_CONFIG
echo "-------------------------------------"
echo "Set git user and email for user -gce- to:"
echo $GIT_NAME
echo $GIT_EMAIL
sudo su -c "git config --global user.name $GIT_NAME" gce
sudo su -c "git config --global user.email $GIT_EMAIL" gce
echo "-------------------------------------"

echo ""
echo "Login to RStudio with username -gce-"
echo ""

echo "----------------------------------------"
echo "Start installing R-libs with heavy dependencies in 30 seconds"
sleep 30
sudo Rscript ./libs_with_heavy_deps.R

