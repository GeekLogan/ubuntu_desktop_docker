#!/bin/bash

# This script is run as the docker entrypoint as root before
# launching daemons and the user startup below

/usr/sbin/sshd

su ubuntu -c"/bin/bash /home/ubuntu/startup2.sh"

