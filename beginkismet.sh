#!/bin/sh

#echo Starting Kismet
echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]" Starting Kismet...

#sleep 5

#nohup /usr/bin/kismet_server --daemonize &
nohup sudo /usr/bin/kismet_server --daemonize > /dev/null 2>&1 &
