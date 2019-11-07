# Use anaconda image with python 2 as base image
FROM continuumio/anaconda2

# Update debian packages in the container
RUN apt update -y

# Unattended install
# Reference: https://unix.stackexchange.com/questions/22820/how-to-make-apt-get-accept-new-config-files-in-an-unattended-install-of-debian-f
RUN apt upgrade -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -y 

# Install useful or required packages
RUN apt install sudo -y
RUN apt install nano -y
RUN apt install tmux -y

# Both bioconda and conda-forge channels needed to install pymvpa properly
RUN conda install -c bioconda -c conda-forge pymvpa -y

# Install all the other needed dependencies
# nibabel etc...

# Create a new user called ubuntu since we do not want to be using 'root' user by default
# Still not super secure but better than uid = 0 i.e. root
# Note that the uid and gid will get overwritten when we want to mount a share folder
RUN adduser --disabled-password -u 999 --gecos "" ubuntu
RUN sudo usermod -aG sudo ubuntu

# Update the sudoer file
RUN printf '\n# So that we can use ubuntu instead of root \nubuntu ALL=(ALL) NOPASSWD: ALL\n' | EDITOR='tee -a' visudo

# Restart sudo just in case to refresh sudoer
RUN service sudo restart

# Set up launcher script for jupyter lab
RUN mkdir /opt/launcher

# Copy the jupyter launch script into container image
# Alias already created in .bashrc of template folder
COPY --chown=ubuntu:ubuntu util/jupyter_pymvpa_lab.sh /opt/launcher/
RUN chmod 755 /opt/launcher/jupyter_pymvpa_lab.sh
