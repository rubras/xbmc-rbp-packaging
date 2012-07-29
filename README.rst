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
