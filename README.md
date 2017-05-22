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
   i.  Initial setup
   * login (pi/raspbery)
   * sudo raspi-config
   * Change Password 
   * Change Hostname
   * Boot Options - Console Autologin
   * Localisation Options - Time Zone
   * Interfacing Options - SSH enabled
   * Advanced - Expand Filesystem
   * - - reboot - -
   * (ahh, now we can SSH in :)
   * Fix the keyboard layout:
   * sudo nano /etc/default/keyboard
   * and do changes to look like this:
      ```
      XKBMODEL="pc104"
      XKBLAYOUT="us"
      ```
   * save changes, then: 
      ```
      sudo setupcon
      ```

   ii. Install Some Goodies
   
   * sudo apt-get update
   * sudo apt-get install vim
   * (and then configure the ~/.vimrc file with stuff like syntax on, set number, colo desert)
   * edit ~/.bashrc file to fix things like alias' and stuff
   * - - logout / login - -
   * sudo apt-get install kismet
   * sudo apt-get install tshark
   * sudo apt-get install git
   * sudo apt-get install zip

   iii. setup the environment
   * from ~/
   * mkdir kismet
   * mkdir zips
   * mkdir extras
    

4. Get the GPS setup (See link to blog below)


```$ sudo lsusb```
Bus 001 Device 005: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port

```$ cat /var/log/syslog | grep ttyUSB0```
raspdriver2 kernel: [   11.644476] usb 1-1.4: pl2303 converter now attached to ttyUSB0

```
$ sudo apt-get install gpsd gpsd-clients python-gps
$ sudo gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock
```


   THEN > IMPORTANT:  modify ```/etc/default/gpsd``` with the following lines: 
    ```
        DEVICES="/dev/ttyUSB0"
        GPSD_SOCKET="/var/run/gpsd.sock"
    ```

Test it out in a window (or somewhere with GPS reception)
```$ cgps -s```

( do the whole "ntp clock synch thing" from the blog if you want )


Reference-style: 
![alt text][pic2]
[pic1]: https://github.com/hikenbike83/raspdriver2.0/blob/master/photos/IMG_0331.jpg "Logo Title Text 1"
[pic2]: https://github.com/hikenbike83/raspdriver2.0/blob/master/photos/IMG_0332.jpg "Logo Title Text 2"



5. Modify the Automotive DC plugs to provide power to the Pi and the USB Hub & Install in Housing.
    1. This part is particularly important, as the USB hub needs to be powered.
    2. The Pi doesn't have the power available to power the GPS and WiFi Dongles.
    3. Automotive DC plug will terminate into the input of the 2 step down transformers.
    4. The output of the step down transformers will be the male 2.1 x 5.5mm DC Power Pigtails.
    5. Give one pigtail the DC to USB adaptor for the Pi, Screen, and UPS.
    6. Give the other pigtail directly into the USB hub

6. ~~Install the UPS~~

7. !!!!
   Clone this repository to the ```~/``` directory of the Pi
   
   Move the kismet.conf file to 
   ```
   /etc/kismet/kismet.conf
   ```
   
8. !!!!
    Add the line: 
    ```
    home/pi/beginkismet.sh
    ```
    to the Pi's ```/etc/rc.local``` to ensure it runs at startup.

9. Setup UPS script to execute powerdown.sh whenever power is lost. **_Work in progress_**.



# Project Operation

1. With all the hardware plugged in as listed above, power on the Pi.
2. The ```/home/pi/beginkismet.sh``` script launches Kismet in the background.
3. While Kismet does it's thing, the ```/home/pi/kismet/``` directory starts populating with datas.


   1. If you really want, you can check things while this is going by launching the Kismet Client from the command line.
   2. Or run gpsd or gpsmon to see if that's working 
       * I prefer to just check in the Kismet GUI from Windows > GPS Details.


4. So everything will auto run on it's own.

5. When done !!! IMPORTANT !!! and before you power off the vehicle:

   1.  Run one of the finishkismet scripts depending if you want the pi to power off when done.  This
     will wrap up the files and move the pcaps (zipped up) into the 
     ``` ~/zips``` directory and move the other files (also zipped) to the ```~/extras``` directory.
     
      * ```finishkismet.sh```  {shuts the pi down when done}
      * ```finishkismetDONTSHUTDOWN.sh```  {doesn't shut the pi down when done}





## Software

Raspbian (use this for download of image and installation of OS)
https://www.raspberrypi.org/documentation/installation/installing-images/README.md



## Apt Packages Installed

* vim (fav editor)
* kismet (kinda easy button for wardriving)



## Hardware

### 7" TouchScreen
http://www.element14.com/community/docs/DOC-78156?ICID=rpiaccsy-topban-products
http://www.amazon.com/OFFICIAL-RASPBERRY-FOUNDATION-TOUCHSCREEN-DISPLAY/dp/B0153R2A9I

### GPS
http://blog.retep.org/2012/06/18/getting-gps-to-work-on-a-raspberry-pi/

My personal favorite GPS:
[GlobalSat ND-100S USB GPS Dongle](https://www.amazon.com/GlobalSat-ND-100S-USB-GPS-Dongle/dp/B003WNHGAO/ref=sr_1_fkmr0_1?ie=UTF8&qid=1379103714&sr=8-1-fkmr0)

### PiUPS #1
[Pi UPS - Raspberry Pi Backup Power Supply by CW2.](http://www.amazon.com/Pi-UPS-Raspberry-Backup-Supply/dp/B00JNFP71A)
[PiUPS Page](http://piups.net/support/)
* This one didn't work for me.  It wasn't recognized (perhaps due to the touchscreen) so it never shut the Pi down.
* It did however keep it running when power was lost, so that was nice until the second UPS arrives.

### DC to USB (For Pi Power)
[Super Power Supply® 5.5x2.1mm (5.5mm 2.1xmm) Female to Micro USB Male Plug Charge Cable Plug](http://www.amazon.com/Super-Power-Supply®-5-5x2-1mm-2-1xmm/dp/B00S6N5I64)


### DC Step Down Transformer
[SINOLLC DC 12V 24V to 5V 3A Converter Step Down Regulator 5V Regulated Power Supplies Transformer Converter](http://www.amazon.com/SINOLLC-Converter-Regulator-Regulated-Transformer/dp/B00J3MHTYG)

### Automotive Plug with Two Tails
[EDO Tech® 11' Long Twin Plug Car Charger Cable DC Adapter for Sylvania SDVD8727 SDVD8730 SDVD8732 SDVD8716-COM Dual Screen DVD Player](http://www.amazon.com/Sylvania-SDVD8727-SDVD8730-SDVD8732-SDVD8716-COM/dp/B007QP7582)

### 10 Pack of DC plugs
[MassMall High Quality 10pack 10 inch(30cm) 2.1 x 5.5mm DC Power Pigtail MALE](http://www.amazon.com/MassMall-Quality-10pack-5-5mm-Pigtail/dp/B00XTY8WUY)

### Wireless Keyboard
[Rii Mini Wireless 2.4GHz Keyboard with Mouse Touchpad Remote Control, Black (mini X1) for Raspberry pi/HTPC/XBMC/Google and Android TV KP-810-10LL](http://www.amazon.com/Rii-mini-X1-Raspberry-KP-810-10LL/dp/B00I5SW8MC)

### Alfa WiFi Cards
[Alfa Brand AWUS036EW](http://www.alfa.net.my/webshaper/store/viewProd.asp?pkProductItem=27)
* I believe these have been replaced with a 1000mw version:
* http://www.amazon.com/802-11g-Wireless-Long-Rang-Network-Adapter/dp/B0035GWTKK

### USB Hub
[j5create USB 3.0 4-Port HUB JUH340](http://www.amazon.com/USB-3-0-4-Port-HUB-JUH340/dp/B00HLOLQ6K)




