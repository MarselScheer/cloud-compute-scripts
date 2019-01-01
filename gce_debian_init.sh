#!/bin/bash

# Prepares an *Debian 9 + TF1-X* image on google cloud platform for R

export LANG=en_US.UTF-8

echo "Use -gce- for R-projects"
echo "User gce created. Set password for gce"

sudo useradd -m gce
sudo passwd gce
sleep 3

echo "echo 'export EDITOR=emacs' >> /home/gce/.bashrc" | sudo bash
echo "sudo cp -r /home/m/.ssh /home/gce/" | sudo bash
echo "sudo chown -R gce:gce /home/gce/.ssh" | sudo bash

sudo ln -sf /usr/share/zoneinfo/GMT /etc/localtime

sudo apt-get update
sudo apt-get -y upgrade

sudo chmod 666 /etc/apt/sources.list
sudo echo 'deb http://ftp.gwdg.de/pub/misc/cran/bin/linux/debian stretch-cran35/' >> /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list
sudo apt-get install -y dirmngr libcurl4-openssl-dev libssl-dev

n=0
until [ $n -ge 20 ]
do
    sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && break
    echo "Try $n: failed to fetch key for r-installation. Retry in 5 seconds"
    n=$(expr $n + 1)
    sleep 5
done


sudo apt-get update
sudo apt-get install -y r-base r-base-dev

sudo apt-get install -y htop ranger python-pip git tig emacs-nox pandoc ed ncdu
echo "export EDITOR=emacs" >> ~/.bashrc

sudo Rscript ./libs.R


echo "Install keras for user -gce- ..."
sleep 3
echo "su gce -c \"R -e 'keras::install_keras()'\""  | sudo bash
echo "Moving the tensorflow installation that is made during the R-Keras installation because the vm-image already has TPU-optimized tensorflow installation"
echo "mv /home/gce/.virtualenvs/r-tensorflow /home/gce/.virtualenvs/r-tensorflow.org"
sleep 3
sudo mv /home/gce/.virtualenvs/r-tensorflow /home/gce/.virtualenvs/r-tensorflow.org

sudo su -c "mkdir /home/gce/projects" gce
echo "-------------------------------------"
echo "created a projects-folder for -gce-."
echo "copy up.sh and down.sh to the corresponding project-folder, e.g. /home/gce/projects/foo/"
echo "in order to easily sync the project with another machine"
echo "in order to upload to /home/gce/projects add a public key to /home/gce/.ssh/authorized_keys"


source ./GIT_CONFIG
echo "-------------------------------------"
echo "Set git user and email for user -gce- to:"
echo $GIT_NAME
echo $GIT_EMAIL
sudo su -c "git config --global user.name $GIT_NAME" gce
sudo su -c "git config --global user.email $GIT_EMAIL" gce
echo "-------------------------------------"

echo "execute: source ~/.bashrc"

source ./PUSHBULLET

if [ $PUSHBULLET_KEY != 'dummy' ]
then
    R -e "RPushbullet::pbPost(type = 'note', title = 'cloud-compute-script', body = 'gce_debian_init.sh done', apikey = '$PUSHBULLET_KEY', devices = '$PUSHBULLET_DEV', verbose = FALSE)"
else
    echo "No pushbullet key specified."
fi
