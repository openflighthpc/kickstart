#!/bin/bash
#(c)2017 Alces Software Ltd. HPC Consulting Build Suite
# vim: set filetype=kickstart :

#MISC
text
reboot
skipx
install

#SECURITY
firewall --enabled
firstboot --disable
selinux --disabled

#AUTH
auth  --useshadow  --enablemd5
#GENERATE with openssl passwd -1 $PASSWD
rootpw --iscrypted $1$rHMcGNPo$UEb1Xxd1dMeT/h0kTUg611 

#LOCALIZATION
keyboard uk
lang en_GB
timezone  Europe/London

#REPOS
url --url=https://mirror.bytemark.co.uk/centos/7.6.1810/os/x86_64/

#DISK
%include /tmp/disk.part

#PRESCRIPT
%pre
set -x -v
exec 1>/tmp/ks-pre.log 2>&1

DISKFILE=/tmp/disk.part
bootloaderappend="console=tty0 console=ttyS1,115200n8"
cat > $DISKFILE << EOF
zerombr
bootloader --location=mbr --driveorder=vda --append="$bootloaderappend"
clearpart --all --initlabel

#Disk partitioning information
part biosboot --fstype=biosboot --size=1 --ondisk vda
part /boot --fstype ext4 --size=512 --asprimary --ondisk vda
part pv.01 --size=1 --grow --asprimary --ondisk vda
volgroup system pv.01
logvol  /  --fstype ext4 --vgname=system  --size=1 --grow --name=root
logvol  swap  --fstype swap --vgname=system  --size=2048  --name=swap

EOF

%end

#PACKAGES
%packages --ignoremissing
@base
@Core
%end

#POSTSCRIPTS
%post --nochroot
set -x -v
exec 1>/mnt/sysimage/root/ks-post-nochroot.log 2>&1


%end

%post
set -x -v
exec 1>/root/ks-post.log 2>&1


%end
