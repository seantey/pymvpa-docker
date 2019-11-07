#!/bin/bash

### Make sure to chmod +x launch.sh to add execute permissions!

## Change to home directory
cd /home/ubuntu/pymvpa

## Stop existing jupyter notebook server on port 8888 if exists
sudo /opt/conda/bin/jupyter notebook stop 8888

## Launch jupyter notebook or lab server
# We need to specify ip to prevent socket.error: [Errno 99] Cannot assign requested address
# We also need to use --allow-root because the user inside the container has root authorization
# Not entirely sure why even though the user is ubuntu in group ubuntu
# Could be an unintentional side effect from adding ubuntu to sudoer file in Dockerfile step?
# Also, maybe consider prompting user for jupyter notebook token password instead of hard coding.
sudo /opt/conda/bin/jupyter lab --port 8888 --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='pymvpa'
