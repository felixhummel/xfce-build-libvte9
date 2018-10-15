# Felix' libvte

Fix Escape-Sequences for Ctrl-Home and Ctrl-End in libvte9.

Patch from https://bugzilla.gnome.org/show_bug.cgi?id=600659

```
sudo apt-get --yes install build-essential devscripts lintian diffutils patch patchutils
```

```
make
make install
```

Restart terminal emulator and try it:
```
vi -c 'read !seq 99'
```
