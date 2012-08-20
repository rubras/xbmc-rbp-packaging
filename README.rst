XBMC packaging for the Raspberry Pi
===================================

Requirements
------------
To make debian packages, there are some requirements:

    sudo apt-get install pdebuild

You'll also need to register the raspbian repository public key with apt:

    wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -

TBC

Usage
-----
1. Clone the repository and go into it

    git clone https://github.com/Diaoul/xbmc-rbp-packaging.git
    cd xbmc-rbp-packaging

2. Create the source package

    ./source

3. Create the base chroot for pbuilder

    ./pbuilder create

4. Build xbmc-rbp

    sudo ./pbuilder build *.dsc

Installation
------------
1. Copy generated .deb files to your RPi (from the computer)

    scp work/result/*.deb pi@xxx.xxx.xxx.xxx:/home/pi

2. Install (from the RPi)

    sudo dpkg -i *.deb

3. Fix dependencies

    sudo apt-get install -f

4. Create a udev rule for /dev/tty0 to fix keyboard for simple users (non-root)

    sudo nano /etc/udev/rules.d/98-tty.rules
    KERNEL=="tty[0-9]*", GROUP="tty", MODE="0660"

5. Allow power actions from the power menu of XBMC for the xmbc group (or the group of your choice)

    sudo groupadd xbmc
    sudo nano /var/lib/polkit-1/localauthority/50-local.d/xbmc.pkla
    [Actions for xbmc group]
    Identity=unix-group:xbmc
    Action=org.freedesktop.upower.*;org.freedesktop.consolekit.system.*
    ResultAny=yes
    ResultInactive=yes
    ResultActive=yes

6. Create a dedicated user (or edit one of your choice) with the following groups: xbmc, tty, audio, video, plugdev and input

    sudo useradd xbmc -G xbmc,tty,audio,video,plugdev,input

7. Reboot so everything is reloaded correctly

    sudo reboot

8. Now the xbmc user can run

    xbmc