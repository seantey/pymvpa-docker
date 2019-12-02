#!/bin/bash

# Assume the script is running on a linux (Ubuntu) machine on AWS but should work for personal
# computers as well. This script probably does not work on most other operating systems.

# Usage:

# Initialization script does the following:
# (1) Create folders to be mounted on the Docker container thus acting as a shared folder
# (2) Install Docker
# (3) Create the container
# 

# TODO
## To remove alias, do...

sudo apt update -y
sudo apt upgrade --y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew

# Create file directories for shared docker folder
mkdir -p ~/pymvpa-mount-folder
mkdir -p ~/pymvpa-mount-folder/pymvpa/code
mkdir -p ~/pymvpa-mount-folder/pymvpa/fmri-data
mkdir -p ~/pymvpa-mount-folder/pymvpa/sean-tutorials
mkdir -p ~/pymvpa-mount-folder/pymvpa/original-pymvpa-tutorials

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

# # TODO this seems odd, why did I put an alias to downlaoded file instead of newly copied /bin file?
# # Add alias for container launch script
# # First check if we are in the correct working directory and the launch script is exists
# if [ -f "$(pwd)/util/pymvpa_docker_start.sh" ]
# then
#     # File exist
#     if cat ~/.bashrc | grep -q 'alias launch-pymvpa='
#     then
#         echo 'Alias already exists in ~/.bashrc'
#     else
#         echo 'Adding launch-pymvpa shell alias to ~/.bashrc'
#         echo "alias launch-pymvpa='$(pwd)/util/pymvpa_docker_start.sh'" >> ~/.bashrc
#     fi
# else
#     # File does not exist
#     echo 'WARNING script running in wrong working directory! Exiting script now.'
#     exit 1
# fi

# TESTING alias to bin file
# Add alias for container launch script
if cat ~/.bashrc | grep -q 'alias launch-pymvpa='
then
    echo 'Alias already exists in ~/.bashrc'
else
    echo 'Adding launch-pymvpa shell alias to ~/.bashrc'
    echo "alias launch-pymvpa='/usr/local/bin/pymvpa_docker_start.sh'" >> ~/.bashrc
fi


# Run bashrc so that we can immediately use the new alias instead of logging in and out
source ~/.bashrc

echo 'PyMVPA Docker initialization complete'
