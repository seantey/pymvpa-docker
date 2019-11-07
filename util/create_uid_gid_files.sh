#!/bin/bash

# Generate a passwd and group file with uid and gid that matches the host so that
# the shared folder permissions work for both host and container

echo "ubuntu:x:$(echo $UID):$(echo $(id -g $UID)):,,,:/home/ubuntu:/bin/bash" | 
cat template/passwd_template - > ~/.pymvpa_passwd

echo "ubuntu:x:$(echo $(id -g $UID)):" | 
cat template/group_template - > ~/.pymvpa_group

# Small note about cat
# For: cat passwd_template -
# The minus sign at the end gets translated to stdin
# This command is like printing 2 files but the second file is stdin

# need to make sure the uid is in sudoer file.... ?
