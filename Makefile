default: sudo tools clean libvte9_0.28.2-5ubuntu1.1_amd64.deb

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
	sudo apt-get --yes build-dep libvte9

libvte9_0.28.2-5ubuntu1.1_amd64.deb: $(patch_name) vte-0.28.2
	cd vte-0.28.2/ \
		&& patch -p1 < ../$(patch_name) \
		&& dch --nmu "patch C-Home, C-End" \
		&& debuild -us -uc -b

.PHONY: install
install: libvte9_0.28.2-5ubuntu1.1_amd64.deb
	sudo dpkg -i *.deb

tools:
	sudo apt-get --yes install build-essential devscripts lintian patch patchutils

clean:
	rm -rf vte-* vte_* libvte* python-vte*.deb
