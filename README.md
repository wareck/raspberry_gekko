Download "Raspberry Pi OS with desktop" image (https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-32-bit)

Burn the sdcard

If you plan to use a keyboard and a mouse => install sdcard in raspberry and start it.

Follow the nexts steps otherwise go to the end of this guide (headless use)

After boot, configure Raspbian :

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
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View4.png">
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View5.png">
</p>

If you use screen/keyboard/mouse when update is finished, open a terminal :

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View6.png">
</p>

git clone git clone https://github.com/wareck/raspberry_gekko

cd raspberry_gekko

./install

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View7.png">
</p>

take a coffe and wait...

If you wants to use software with an headless raspberry (without screen/keyboard/mouse)

when you brun the sdcard, add the file "ssh" with no extention on the sdcard

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View9.png">
</p>

then boot the raspberry and use ssh (putty or ssh) to connect on raspberry.

then do the same command on the "install step"



After installation, reboot Raspberry.

you will need to edit the file .cgminer/cgminer.conf with your adresse, pool adresses, setup...

To connect raspberry with VNC :

Use the raspberry IP and add ":1" at the end

<p align="center">
<img src="https://raw.githubusercontent.com/wareck/raspberry_gekko/master/docs/View8.png">
</p>
