#!/bin/bash

# Assume the script is running on a linux (Ubuntu) machine on AWS but should work for personal
# computers as well. This script does not work on any other operating system.

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

bash # launch sub shell so that we can go back to the original working directory easily
cd # go to home directory
mkdir -p pymvpa-mount-folder

cd pymvpa-mount-folder

mkdir -p pymvpa

cd pymvpa
mkdir -p code
mkdir -p fmri-data
mkdir -p sean-tutorials
mkdir -p original-pymvpa-tutorials

exit 0 # Go back to parent process and continue running this script

# Copy the home directory hidden files from template
cp -r util/template/homefolder/. ~/pymvpa-mount-folder/

# Generate a passwd and group file with uid and gid that matches the host so that
# the shared folder permissions work for both host and container
bash util/create_uid_gid_files.sh

# Fetch the fMRI data from S3
## TODO

# Install docker from debian using docker.io instead of docker-ce
# Reasoning: https://stackoverflow.com/questions/45023363/what-is-docker-io-in-relation-to-docker-ce-and-docker-ee
# Even though the official docker docs use docker-ce, I choose to use docker.io because it seems easier to install
# from a docker user P.O.V and it seems relatively up to date which is good enough for me.
sudo apt install docker.io -y

# Download docker image
sudo docker pull seantey/pymvpa-docker:latest

# Alternatively, run the build_image.sh to generate the image
# To create the container either reuse the docker_create_container.sh by renaming the newly built image with:
# sudo docker tag pymvpa-docker:latest seantey/pymvpa:latest
# Or modify the docker_create_container.sh script

# Create the container
./util/docker_create_container.sh

# Add the launch script to path, use the fact that /usr/local/bin is usually already in PATH enviroment
cp util/pymvpa_docker_start.sh /usr/local/bin

# Add alias for container launch script
# First check if we are in the correct working directory and the launch script is exists
if [ -f "$(pwd)/util/pymvpa_docker_start.sh" ]
then
    # File exist
    if cat ~/.bashrc | grep -q 'alias launch-pymvpa='
    then
        echo 'Alias already exists in ~/.bashrc'
    else
        echo 'Adding launch-pymvpa shell alias to ~/.bashrc'
        echo "alias launch-pymvpa='$(pwd)/util/pymvpa_docker_start.sh'" >> ~/.bashrc
    fi
else
    # File does not exist
    echo 'WARNING script running in wrong working directory! Exiting script now.'
    exit 1
fi

# Run bashrc so that we can immediately use the new alias instead of logging in and out
source ~/.bashrc

echo 'PyMVPA Docker initialization complete'
