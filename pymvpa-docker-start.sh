#!/bin/bash

# Start the container if not running and attach container terminal (attach stdin, stdout, stderr stream)
# If --restart flag provided, restart the the container before running. 

if [ "$1" == "--restart" ]
then
	sudo docker restart pymvpa
else
	sudo docker start pymvpa
fi

sudo docker attach pymvpa
