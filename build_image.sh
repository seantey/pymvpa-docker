#!/bin/bash
# Remove the image if already exist then build the image
# Recommend just pulling from docker hub to run the PyMVPA container

sudo docker build --tag="seantey/pymvpa-docker:latest" --rm .

# Remove dangling images: https://forums.docker.com/t/how-to-remove-none-images-after-building/7050/3
# TODO might show: "docker rmi" requires at least 1 argument. if there are no dangling images. Fix or not fix?
sudo docker rmi $(sudo docker images -f "dangling=true" -q)
