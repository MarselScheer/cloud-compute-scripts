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


source ./GIT_CONFIG
echo "-------------------------------------"
echo "Set git user and email for user -gce- to:"
echo $GIT_NAME
echo $GIT_EMAIL
sudo su -c "git config --global user.name $GIT_NAME" gce
sudo su -c "git config --global user.email $GIT_EMAIL" gce
echo "-------------------------------------"
sleep 3


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

echo "execute: source ~/.bashrc"

