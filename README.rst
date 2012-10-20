XBMC packaging for the Raspberry Pi
===================================

Requirements
------------
To make debian packages you will need a maximum of memory so use the 240MB
memory split and create yourself a 512MB swap.

Install a few packages aswell::

    sudo apt-get install pbuilder dh-autoreconf git

And update `/etc/apt/sources.list` to add the following::

    deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi
    deb-src http://ftp.fr.debian.org/debian/ sid main contrib non-free
    deb-src http://ftp.fr.debian.org/debian/ experimental main contrib non-free


Usage
-----
1. Clone the repository and go into it::

    git clone https://github.com/Diaoul/xbmc-rbp-packaging.git
    cd xbmc-rbp-packaging

2. Create the source package::

    make source

3. Create the base chroot for pbuilder on first run or update it::

    make create|update

4. Build dependencies::

    make dependencies

5. Build xbmc-rbp::

    make build

Installation
------------
1. Install::

    sudo dpkg -i /var/cache/pbuilder/result/*.deb

2. Fix dependencies::

    sudo apt-get install -f


Running as non-root
-------------------
1. Create a udev rule for /dev/tty0 to fix keyboard::

    sudo nano /etc/udev/rules.d/98-tty.rules
    KERNEL=="tty[0-9]*", GROUP="tty", MODE="0660"

2. Allow power actions from the power menu of XBMC for the xmbc group (or the group of your choice)::

    sudo groupadd xbmc
    sudo nano /var/lib/polkit-1/localauthority/50-local.d/xbmc.pkla
    [Actions for xbmc group]
    Identity=unix-group:xbmc
    Action=org.freedesktop.upower.*;org.freedesktop.consolekit.system.*
    ResultAny=yes
    ResultInactive=yes
    ResultActive=yes

3. Create a dedicated user (or edit one of your choice) with the following groups: xbmc, tty, audio, video, plugdev and input::

    sudo useradd xbmc -m -U -G tty,audio,video,plugdev,input

4. Reboot so everything is reloaded correctly::

    sudo reboot

5. Now the xbmc user can run::

    xbmc
