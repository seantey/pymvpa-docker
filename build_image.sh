#!/bin/bash
# Remove the image if already exist then build the image
# Recommend just pulling from docker hub to run the PyMVPA container

sudo docker image rm pymvpa-docker:latest

# remove intermediate image
sudo docker build --tag="pymvpa-docker:latest" --rm .
