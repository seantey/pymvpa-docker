#!/bin/bash

sudo docker create \
-it \
-u $(echo $UID):$(echo $(id -g $UID)) \
-v ~/.pymvpa_passwd:/etc/passwd:ro \
-v ~/.pymvpa_group:/etc/group:ro \
-v ~/pymvpa-mount-folder:/home/ubuntu:z \
-w /home/ubuntu \
-h pymvpa-container \
-p 8888:8888 \
--name pymvpa seantey/pymvpa-docker:latest 

## Note on flags:
# -it # Allocate a tty and keep stdin opened (interactive)
# -u # set uid and gid within container
# -v ~/.pymvpa_passwd:/etc/passwd:ro \ # remap the passwd file so that shared folder permissions match
# -v ~/.pymvpa_group:/etc/group:ro \ # remap the group file
# -v ~/pymvpa-docker:/home/ubuntu # Mount a shared folder between host and container
# -w /home/ubuntu # Set initial working directory
# -h pymvpa-container # Set hostname
# -p 8888:8888 # Map ports between container and host for Jupyter lab access
# --name pymvpa pymvpa-docker:latest # Name of base image for container

# Reference about the -it flag
# https://www.reddit.com/r/docker/comments/8ip97p/why_does_container_exit_immediately/

# A persistent problem that I couldn't find an elegant solution to when creating a shared folder 
# between the host and the container is that for some reason when you mount the host volume onto the
# container, from the container side you will see that the uid and gid of the folder is the same as 
# the host uid gid. There's no auto translation of uid and gid between host and container.
# The z option below does not work, therefore I will just set the uid and gid when creating the container.
# Using $(echo $UID) to get uid from PATH and $(echo $(id -g $UID)) to get the gid

# I also mapped the entire homefolder in the container to the external folder to fix permission issues.

# For personal reference:

# The Z option in the volume mount is suggested by:
# https://stackoverflow.com/questions/24288616/permission-denied-on-accessing-host-directory-in-docker
# The z option indicates that the bind mount content is shared among multiple containers.
# The Z option indicates that the bind mount content is private and unshared.

# Failed experimental flags for seamless shared folder
# -v ~/pymvpa-mount-folder:/home/ubuntu/pymvpa:z \
# --mount type=bind,source=~/pymvpa-mount-folder,target=/home/ubuntu/pymvpa \
# --mount type=bind,source=$(echo $HOME)/pymvpa-mount-folder,target=/home/ubuntu/pymvpa \

# Try creating a named volume that links to the host folder (doesn't work either)
# First run
# sudo docker volume create --driver local \
#       --opt type=none \
#       --opt device=$(echo $HOME)/pymvpa-mount-folder \
#       --opt o=bind \
#       pymvpa-test-vol
# Then set flag in create command:
# --mount type=volume,source=pymvpa-test-vol,destination=/home/ubuntu/pymvpa \
