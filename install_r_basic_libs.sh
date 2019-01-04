#!/bin/bash

echo "A pushbullet notification is send after installation"
sleep 3
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


source ./PUSHBULLET

if [ $PUSHBULLET_KEY != 'dummy' ]
then
    R -e "RPushbullet::pbPost(type = 'note', title = 'cloud-compute-script', body = 'gce_debian_init.sh done', apikey = '$PUSHBULLET_KEY', devices = '$PUSHBULLET_DEV', verbose = FALSE)"
else
    echo "No pushbullet key specified."
fi
