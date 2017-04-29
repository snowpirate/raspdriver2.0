# raspdriver2.0
A Raspberry Pi based Automatic Wardriving Solution.
Updated to use Kismet as the wifi engine.




### Abstract

This collection of short BASH scripts allows a stock Raspberry Pi to become an automotive accessory that captures packets as you drive around.  The overall goal is to make it autonomous, requiring no user intervention whatsoever.  The final goal will be to port the entire project over to Python.

### Important note!

All the absolute paths are currently using /home/pi as the working directory.  Please adjust files accordingly when cloning this repository. (I might fix this later)



### Info

The project was originally built with parts laying around, so I'll do my best to find them for sale online and put in here.  Level of detail in this version is not walkthrough from start to finish, assumes you can do "some assembly required" projects and put it all together.  Best effort is given to make it a logical flow.

I went with a wireless keyboard & the touchsceen to be able to have a standalone machine for troubleshooting/usage in car.  Not really required, but it is pretty sweet to have.  The other option is bring something else that can SSH into the pi (yuck!). 

Yes, I realize some of this is not as "streamlined" as possible, but it's the configuration that works for me, I intend on doing other things with the project after playing with this for a while, so some "modularity" was taken to be able to swap between projects.



# Project Setup

1. Make bootable OS SD card with latest Raspbian
2. Install the touchscreen (this is where you can get creative.  I recommend making a "case" for everything at this point)
3. Boot up and install required software (give it the internet)

4. !!!!
   Get the GPS setup (See link to blog)
    1. I needed to also modify /etc/default/gpsd with the following lines:
    ```
        DEVICES="/dev/ttyUSB0"
        GPSD_SOCKET="/var/run/gpsd.sock"
    ```
    
5. Modify the Automotive DC plugs to provide power to the Pi and the USB Hub & Install in Housing.
    1. This part is particularly important, as the USB hub needs to be powered.
    2. The Pi doesn't have the power available to power the GPS and WiFi Dongles.
    3. Automotive DC plug will terminate into the input of the 2 step down transformers.
    4. The output of the step down transformers will be the male 2.1 x 5.5mm DC Power Pigtails.
    5. Give one pigtail the DC to USB adaptor for the Pi, Screen, and UPS.
    6. Give the other pigtail directly into the USB hub

6. Install the UPS

7. !!!!
   Clone this repository to the ~/ directory of the Pi
8. !!!!
    Add the line: 
    ```
    home/pi/beginkismet.sh
    ```
    to the Pi's /etc/rc.local to ensure it runs at startup.

9. Setup UPS script to execute powerdown.sh whenever power is lost. ** _Work in progress_ **.



# Project Operation

1. With all the hardware plugged in as listed above, power on the Pi.
2. The [ /home/pi/beginkismet.sh ] script launches Kismet in the background.
3. While Kismet does it's thing, the /home/pi/kismet/ directory starts populating with datas.


   1. If you really want, you can check things while this is going by launching the Kismet Client from the command line.
   2. Or run gpsd or gpsmon to see if that's working (but I prefer to just check in the Kismet GUI
      from Windows > GPS Details.


4. So everything will auto run on it's own.

5. When done !!! IMPORTANT !!! and before you power off the vehicle:

   1.  Run one of the finishkismet scripts depending if you want the pi to power off when done.  This
     will wrap up the files and move the pcaps (zipped up) into the ~/zips directory and move the other files
     (also zipped) to the ~/extras directory.
     
      * finishkismet.sh  {shuts the pi down when done}
      * finishkismetDONTSHUTDOWN.sh  {doesn't shut the pi down when done}





## Software

Raspbian (use this for download of image and installation of OS)
https://www.raspberrypi.org/documentation/installation/installing-images/README.md



## Apt Packages Installed

vim (fav editor)
kismet (kinda easy button for wardriving)



## Hardware

### 7" TouchScreen
http://www.element14.com/community/docs/DOC-78156?ICID=rpiaccsy-topban-products
http://www.amazon.com/OFFICIAL-RASPBERRY-FOUNDATION-TOUCHSCREEN-DISPLAY/dp/B0153R2A9I

### GPS
http://blog.retep.org/2012/06/18/getting-gps-to-work-on-a-raspberry-pi/

### PiUPS #1
http://www.amazon.com/Pi-UPS-Raspberry-Backup-Supply/dp/B00JNFP71A
http://piups.net/support/
Pi UPS - Raspberry Pi Backup Power Supply by CW2.
* This one didn't work for me.  It wasn't recognized (perhaps due to the touchscreen) so it never shut the Pi down.
* It did however keep it running when power was lost, so that was nice until the second UPS arrives.

### DC to USB (For Pi Power)
http://www.amazon.com/Super-Power-Supply®-5-5x2-1mm-2-1xmm/dp/B00S6N5I64
Super Power Supply® 5.5x2.1mm (5.5mm 2.1xmm) Female to Micro USB Male Plug Charge Cable Plug

### DC Step Down Transformer
http://www.amazon.com/SINOLLC-Converter-Regulator-Regulated-Transformer/dp/B00J3MHTYG
SINOLLC DC 12V 24V to 5V 3A Converter Step Down Regulator 5V Regulated Power Supplies Transformer Converter

### Automotive Plug with Two Tails
http://www.amazon.com/Sylvania-SDVD8727-SDVD8730-SDVD8732-SDVD8716-COM/dp/B007QP7582
EDO Tech® 11' Long Twin Plug Car Charger Cable DC Adapter for Sylvania SDVD8727 SDVD8730 SDVD8732 SDVD8716-COM Dual Screen DVD Player

### 10 Pack of DC plugs
http://www.amazon.com/MassMall-Quality-10pack-5-5mm-Pigtail/dp/B00XTY8WUY
MassMall High Quality 10pack 10 inch(30cm) 2.1 x 5.5mm DC Power Pigtail MALE

### Wireless Keyboard
http://www.amazon.com/Rii-mini-X1-Raspberry-KP-810-10LL/dp/B00I5SW8MC
Rii Mini Wireless 2.4GHz Keyboard with Mouse Touchpad Remote Control, Black (mini X1) for Raspberry pi/HTPC/XBMC/Google and Android TV KP-810-10LL

### Alfa WiFi Cards
Alfa Brand AWUS036EW
http://www.alfa.net.my/webshaper/store/viewProd.asp?pkProductItem=27
* I believe these have been replaced with a 1000mw version:
* http://www.amazon.com/802-11g-Wireless-Long-Rang-Network-Adapter/dp/B0035GWTKK

### USB Hub
j5create USB 3.0 4-Port HUB JUH340
http://www.amazon.com/USB-3-0-4-Port-HUB-JUH340/dp/B00HLOLQ6K

