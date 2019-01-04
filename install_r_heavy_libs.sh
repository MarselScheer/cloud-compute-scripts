#!/bin/bash

echo "A pushbullet notification is send out after installation"
sleep 3
sudo Rscript ./libs_with_heavy_deps.R


source ./PUSHBULLET
if [ $PUSHBULLET_KEY != 'dummy' ]
then
    R -e "RPushbullet::pbPost(type = 'note', title = 'cloud-compute-script', body = 'gce_rstudio.sh done. R-libs with heavy dependencies installed', apikey = '$PUSHBULLET_KEY', devices = '$PUSHBULLET_DEV', verbose = FALSE)"
else
    echo "No pushbullet key specified."
fi
