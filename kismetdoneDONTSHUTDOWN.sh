#!/bin/sh

clear

echo
echo Powering Down Fusion Reactors...
echo
# sleep 1


echo Please Wait...

sudo killall kismet_server
sleep 5


zip /home/pi/kismet/caps.zip /home/pi/kismet/*.pcapdump
sudo rm -f /home/pi/kismet/*.pcapdump

sleep 1
zip /home/pi/kismet/extras.zip /home/pi/kismet/Kismet* > /dev/null 2>&1

current_time=$(date "+%Y.%m.%d-%H.%M.%S")

mv /home/pi/kismet/caps.zip /home/pi/zips/$current_time.caps.zip
mv /home/pi/kismet/extras.zip /home/pi/extras/$current_time.extras.zip


sudo rm -f /home/pi/kismet/Kismet*

echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]"  All Done!!!
