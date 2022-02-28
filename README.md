This script will install cgminer-gekko, autostart at boot and vncserver.

**Prepare sdcard:**

Download "Raspberry Pi OS with desktop" image 

(https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit)

Burn the sdcard

**If you plan to use a keyboard and a mouse => install sdcard in raspberry and start it and follow this guide.**


**I you plan to use raspberry headless (without screen/keyboard/mouse):**

add a file called "ssh" without extension on the raspberry sdcard. 

It will enable ssh and you will can connect to raspberry with ssh (command line on linux or putty on windows)

then go directly to "install step"


**After boot, configure Raspbian:**

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View1.png">
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View2.png">
</p>1

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View3.png">
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View5.png">
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View4.png">
</p>

If you use screen/keyboard/mouse when update is finished, open a terminal :

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View6.png">
</p>

**INSTALL :**

git clone git clone https://github.com/wareck/raspberry_gekko

cd raspberry_gekko

./install

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View7.png">
</p>

take a coffe and wait...



**After installation, reboot Raspberry.**

you will need to edit the file .cgminer/cgminer.conf with your adresse, pool adresses, setup...

To connect raspberry with VNC :

Use the raspberry IP and add ":1" at the end

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View8.png">
</p>


**Donate:**
 - Bitcoin : 1Pu12Wimuy6n7csyHkEjZXGXnAQzKBwSBp
 - Okcash  : PH3JcR9inEeNZD6gNoLDYwaPAFpgjmrbue
 - Litecoin: M84U8YggaJ7T5E3TcqgcoF2BCTaxBMbCvN
