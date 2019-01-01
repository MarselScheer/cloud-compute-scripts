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

echo "----------------------------------------"
echo "Start installing R-libs with heavy dependencies in 30 seconds. A pushbullet notification is send out afterwards"
sleep 30
sudo Rscript ./libs_with_heavy_deps.R


source ./PUSHBULLET
if [ $PUSHBULLET_KEY != 'dummy' ]
then
    R -e "RPushbullet::pbPost(type = 'note', title = 'cloud-compute-script', body = 'gce_rstudio.sh done. R-libs with heavy dependencies installed', apikey = '$PUSHBULLET_KEY', devices = '$PUSHBULLET_DEV', verbose = FALSE)"
else
    echo "No pushbullet key specified."
fi
