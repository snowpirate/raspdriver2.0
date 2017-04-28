#!/bin/sh

clear

current_time=$(date "+%Y.%m.%d-%H.%M.%S")

echo
echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]" Powering Down Fusion Reactors...
echo
# sleep 1


echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]" Please Wait...

sudo killall kismet_server
sleep 5


zip /home/pi/kismet/caps.zip /home/pi/kismet/*.pcapdump

sleep 1

sudo rm -f /home/pi/kismet/*.pcapdump

zip /home/pi/kismet/extras.zip /home/pi/kismet/Kismet* > /dev/null 2>&1


mv /home/pi/kismet/caps.zip /home/pi/zips/$current_time.caps.zip
mv /home/pi/kismet/extras.zip /home/pi/extras/$current_time.extras.zip

sudo rm -f /home/pi/kismet/Kismet*

echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]"  All Done!!!
echo
echo
echo "[ $(tput setaf 6)PiDrive$(tput sgr0) ]" Shutting down in:
echo    5
sleep 1
echo    4
sleep 1
echo    3
sleep 1
echo    2
sleep 1
echo    1
sleep 1



### this is from the old script
#zip /home/pi/caps.zip /home/pi/*.cap
#sleep 1
#zip /home/pi/extras.zip /home/pi/chan* > /dev/null 2>&1

#current_time=$(date "+%Y.%m.%d-%H.%M.%S")

#mv /home/pi/caps.zip /home/pi/zips/$current_time.caps.zip
#mv /home/pi/extras.zip /home/pi/extras/$current_time.extras.zip


#sudo rm /home/pi/chan*





sudo shutdown -h now
