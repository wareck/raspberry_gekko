#!/bin/bash
wget -q https://raw.githubusercontent.com/wareck/cgminer-gekko/master/configure.ac -O /tmp/configure.ac
v1="`cat /tmp/configure.ac | grep m4_define | awk 'NR==1 {print$2}' | sed 's/[^0-9]//g'`"
v2="`cat /tmp/configure.ac | grep m4_define | awk 'NR==2 {print$2}' | sed 's/[^0-9]//g'`"
v3="`cat /tmp/configure.ac | grep m4_define | awk 'NR==3 {print$2}' | sed 's/[[]//g' | awk '{ print substr( $0, 1, length($0)-2 ) }'`"
function outro {
echo -e "Donate:"
echo -e "Bitcoin  : 1Pu12Wimuy6n7csyHkEjZXGXnAQzKBwSBp"
echo -e "Okcash   : PH3JcR9inEeNZD6gNoLDYwaPAFpgjmrbue"
echo -e "Litecoin : M84U8YggaJ7T5E3TcqgcoF2BCTaxBMbCvN"
echo -e ""
}

echo -e "\e[97mRaspberri Pi CGminer-Gekko install v1.0 (github.com/wareck)\e[0m\n"
if ! dpkg --get-selections | grep -m1 lxde >/dev/null
then
echo -e "\e[95mThis script need a desktop like LXDE"
echo -e "It seems to not be present..."
echo -e "You need to use a full raspberry O.S with desktop..."
echo -e "aborted. \n\e[0m"
outro
exit 0
fi

echo -e "\e[92mThis script will configure and install :\e[0m"
echo "- Cgminer-gekko v$v1.$v2.$v3"
echo "- Cgminer autostart mining at boot"
echo "- Vncserver & service start at boot"
echo ""
sleep 5

echo -e "\e[95mUpdate Raspberry O.S:\e[0m"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install git tightvncserver -y
echo -e "Done"
sleep 1

echo -e "\n\e[95mBuild cgminer-gekko v$v1.$v2.$v3\e[0m":
if [ ! -d ~/cgminer-gekko ]
then
git clone https://github.com/wareck/cgminer-gekko ~/cgminer-gekko
fi
if [ ! -f ~/cgminer-gekko/cgminer ]
then
cd ~/cgminer-gekko/
sudo apt-get install build-essential autoconf automake libtool pkg-config libcurl4-openssl-dev libudev-dev \
libjansson-dev libncurses5-dev libusb-1.0-0-dev zlib1g-dev screen -y
sudo usermod -a -G dialout,plugdev $USER
sudo cp 01-cgminer.rules /etc/udev/rules.d/
CFLAGS="-O2 -march=native" ./autogen.sh
./configure --enable-gekko
make
sudo make install
sudo ldconfig
fi
echo "Done"
sleep 1

echo -e "\n\e[95mGenerate cgminer autostart\e[0m"
if ! grep "#cgminer autostart:" /etc/rc.local >/dev/null
then
		echo $USER >/tmp/user
                sudo bash -c 'sed -i -e "s/exit 0//g" /etc/rc.local'
                sudo bash -c 'echo "#cgminer autostart:" >>/etc/rc.local'
                sudo bash -c 'form=$(cat "/tmp/user") && echo -e "su - $form -c \x27screen -dmS miner cgminer\x27" >>/etc/rc.local'
                sudo bash -c 'echo "exit 0" >>/etc/rc.local'
fi
echo "Done"
sleep 1

echo -e "\n\e[95mGenerate VNC autostart service:\e[0m"
if [ ! -d ~/.vnc ];then mkdir ~/.vnc;fi
if [ ! -f ~/.vnc/xstartup ]
then
cat <<'EOF'>> ~/.vnc/xstartup
#!/bin/sh

xrdb "$HOME/.Xresources"
xsetroot -solid grey
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession
EOF
fi

if [ ! -f /etc/systemd/system/vncserver.service ]
then
cat <<'EOF'>> /tmp/vncboot
[Unit]
Description=TightVNC Server
After=network.target

[Service]
Type=forking
User=pi
ExecStart=/usr/bin/vncserver :1
ExecStop=/usr/bin/vncserver -kill :1

[Install]
WantedBy=multi-user.target
EOF
sudo cp /tmp/vncboot /etc/systemd/system/vncserver.service
sudo systemctl enable vncserver.service

fi
echo -e "Done"
sleep 1

echo -e "\n\e[95mGenrate cgminer.conf\e[0m"
if [ ! -d ~/.cgminer ]; then mkdir ~/.cgminer ;fi
cat <<'EOF'>> ~/.cgminer/cgminer.conf
{
"pools" : [
        {
                "url" : "stratum+tcp://192.168.1.68:3333",
                "user" : "3Bxvpu92KbNvpTbp8iaUYQjd52c45qequt",
                "pass" : "x"
        },
        {
                "url" : "stratum+tcp://pool.solopools.net:3341",
                "user" : "etit1qhh3332g9vqpvpkmnh47lu3wf46rs4n4c2sukhv",
                "pass" : "c=ETIT"
        }
]
,
"api-description" : "cgminer 4.12.0-wrk",
"api-mcast-addr" : "224.0.0.75",
"api-mcast-code" : "FTW",
"api-mcast-des" : "",
"api-mcast-port" : "4028",
"api-port" : "4028",
"api-host" : "0.0.0.0",
"gekko-terminus-freq" : "150.0",
"gekko-2pac-freq" : "150.0",
"gekko-compac-freq" : "100.0",
"gekko-compacf-freq" : "200",
"gekko-newpac-freq" : "150",
"gekko-r606-freq" : "550",
"gekko-tune-down" : "95.0",
"gekko-tune-up" : "97.0",
"gekko-wait-factor" : "0.5",
"gekko-bauddiv" : "0",
"gekko-start-freq" : "100",
"gekko-step-freq" : "2.5",
"gekko-step-delay" : "15",
"gekko-tune2" : "0",
"fallback-time" : "120",
"hotplug" : "5",
"log" : "5",
"shares" : "0",
"suggest-diff" : "0"
}
EOF
echo -e "Done"
sleep 1

echo -e "\n\e[95mConfig tightvncserver:\e[0m"
tightvncserver
sleep 5

clear
echo -e "\e[97mRaspberri Pi CGminer-Gekko install v1.0 (github.com/wareck)\e[0m\n"
echo -e "\e[97mInstall ended.\e[0m"
echo -e "\e[97mYou need to reboot Raspberry PI to enable mining and VNCserver\e[0m"
echo -e "\e[97mDon't forget to edit ./cgminer/cgminer.conf file\e[0m"
echo -e ""
outro
