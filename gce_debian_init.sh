#!/bin/bash

# Prepares an *Debian 9 + TF1-9* image on google cloud platform for R

export LANG=en_US.UTF-8


sudo ln -sf /usr/share/zoneinfo/GMT /etc/localtime

sudo apt-get update
sudo apt-get -y upgrade

sudo chmod 666 /etc/apt/sources.list
sudo echo 'deb http://ftp.gwdg.de/pub/misc/cran/bin/linux/debian stretch-cran35/' >> /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list
sudo apt-get install -y dirmngr libcurl4-openssl-dev libssl-dev
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
sudo apt-get update
sudo apt-get install -y r-base r-base-dev

sudo apt-get install -y htop ranger python-pip git tig emacs-nox pandoc ed ncdu
echo "export EDITOR=emacs" >> ~/.bashrc

sudo Rscript ./libs.R

source ./GIT_CONFIG
echo "Set git user and email to:"
echo $GIT_NAME
echo $GIT_EMAIL
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL


echo "execute: source ~/.bashrc"

