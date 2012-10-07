DEBOOTSTRAP?=qemu-debootstrap
DEB_BUILD_OPTIONS=nocheck

setup: 
	wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -

clean:
	rm -fr xbmc-*
	rm -fr xbmc-rbp-*
	rm -fr xbmc-rbp_*

source:
	./getsource

dependencies:
	mkdir $@
	cd $@ && apt-get source taglib=1.8-1
	pbuilder --build --configfile pbuilderrc --debootstrap $(DEBOOTSTRAP) $@/taglib_1.8-1.dsc
	cd $@ && git clone git://github.com/Pulse-Eight/libcec.git libcec && git checkout libcec-1.9.0
	patch -p0 -d $@/libcec < libcec-pbuilder.patch 
	cd $@/libcec && dpkg-buildpackage -rfakeroot -us -uc -S -sa -d
	pbuilder --build --configfile pbuilderrc --debootstrap $(DEBOOTSTRAP) $@/libcec_1.9.1-1.dsc
	
create:
	pbuilder --create --configfile pbuilderrc --debootstrap $(DEBOOTSTRAP)

update:
	pbuilder --update --override-config --configfile pbuilderrc --debootstrap $(DEBOOTSTRAP)

build:
	DEB_BUILD_OPTIONS="$(DEB_BUILD_OPTIONS)" pbuilder --build --configfile pbuilderrc --debootstrap $(DEBOOTSTRAP) *.dsc
