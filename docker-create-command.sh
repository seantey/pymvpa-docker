#!/bin/bash

sudo docker create \
-it \
-v ~/pymvpa-docker:/home/ubuntu \
-w /home/ubuntu \
-h pymvpa-container \
-p 8888:8888 \
--name pymvpa pymvpa-docker:latest 

## Note on flags:
# -it # Allocate a tty and keep stdin opened (interactive)
# -v ~/pymvpa-docker:/home/ubuntu # Mount a shared folder between host and container
# -w /home/ubuntu # Set initial working directory
# -h pymvpa-container # Set hostname
# -p 8888:8888 # Map ports between container and host for Jupyter lab access
# --name pymvpa pymvpa-docker:latest # Name of base image for container

# Reference about the -it flag
# https://www.reddit.com/r/docker/comments/8ip97p/why_does_container_exit_immediately/
