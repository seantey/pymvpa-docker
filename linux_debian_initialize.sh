#!/bin/bash

# Assume the script is running on a linux machine on AWS but should work for personal
# computers as well. Does not work on MacOS.

# Usage:

# Initialization script does the following:
# (1) Create folders to be mounted on the Docker container thus acting as a shared folder
# (2) Install Docker
# (3) Create the container
# 

## To remove alias, do...

sudo apt update -y
sudo apt upgrade -y # if prompted choose: install the package maintainer's version

# Create file directories for shared docker folder

cd # go to home directory
mkdir pymvpa-shared-folder

cd pymvpa-shared-folder

mkdir code
mkdir fmri-data
mkdir sean-tutorials
mkdir original-pymvpa-tutorials

# Fetch the fMRI data from S3
## TODO

# Install docker from debian using docker.io instead of docker-ce
# Reasoning: https://stackoverflow.com/questions/45023363/what-is-docker-io-in-relation-to-docker-ce-and-docker-ee
# Even though the official docker docs use docker-ce, I choose to use docker.io because it seems easier to install
# from a docker user P.O.V and it seems relatively up to date which is good enough for me.
sudo apt install docker.io

# Download docker image


# Alternatively, run the build-script to generate the image


## If dockerfile version does not exist? Try:
# sudo docker run -it -v ~/pymvpa-docker:/home -p 8888:8888 --name pymvpa seantey/aws-pymvpa


# Create alias to run launch-pymvpa
# conside moving launcher to /home/launcher

# launch bash
# uses docker exec -it pymvpa bash


# NOT IMPORTANT: Launch AFNI viewer through browser

