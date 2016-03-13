default: sudo clean install

export DEBFULLNAME="Felix Hummel"
export DEBEMAIL="xfce4-terminal@felixhummel.de"

.PHONY: sudo
sudo:
	sudo echo "get sudo out of the way now"

patch_name := ctrl_home_end.patch
$(patch_name):
	wget -O $(patch_name) 'https://bug600659.bugzilla-attachments.gnome.org/attachment.cgi?id=265278&action=diff&collapsed=&context=patch&format=raw&headers=1'

vte-0.28.2:
	apt-get source libvte9
	sudo apt-get build-dep libvte9

libvte-dev_0.28.2-5ubuntu2_i386.deb: $(patch_name) vte-0.28.2
	cd vte-0.28.2/ \
		&& patch -p1 < ../$(patch_name) \
		&& dch --nmu "patch C-Home, C-End" \
		&& debuild -us -uc -b

.PHONY: install
install: libvte-dev_0.28.2-5ubuntu2_i386.deb
	sudo dpkg -i libvte-dev_0.28.2-5ubuntu2_i386.deb

clean:
	rm -rf vte-* vte_* libvte* python-vte*.deb
