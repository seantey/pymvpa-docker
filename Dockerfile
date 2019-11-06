# Use anaconda image with python 2 as base image
FROM continuumio/anaconda2

# Update debian packages in the container
RUN apt update -y
RUN apt upgrade  -y

# Install useful or required packages
RUN apt install sudo -y
RUN apt install nano -y
RUN apt install tmux -y

# Create a new user called ubuntu since we do not want to be using 'root' user by default
# Still not super secure but better than uid = 0 i.e. root
RUN adduser --disabled-password -u 999 --gecos "" ubuntu
RUN sudo usermod -aG sudo ubuntu

# Update the sudoer file
RUN printf '\n# So that we can use ubuntu instead of root \nubuntu ALL=(ALL) NOPASSWD: ALL\n' | EDITOR='tee -a' visudo

# Both bioconda and conda-forge channels needed to install pymvpa properly
RUN conda install -c bioconda -c conda-forge pymvpa -y

# Install all the other needed dependencies
# nibabel etc...

# Restart sudo just in case
RUN service sudo restart

# Change user from root to ubuntu
USER ubuntu
