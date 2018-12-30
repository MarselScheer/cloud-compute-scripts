#!/bin/bash

PROJECT=foo

params="--progress --delete -avrzhe ssh --exclude=input --exclude=.Rproj.user gce@$1:/home/gce/projects/$PROJECT/ ."

if [ "$#" -eq 1 ]
then
    echo "dry run"
    rsync --dry-run $params
    exit 1
fi

if [ "$#" -ge 2 ]
then
    echo "downloading..."
    rsync $params
    exit 1
fi
