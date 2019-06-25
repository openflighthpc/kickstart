mkdir -p /opt/diskless/images/image1
yum groups -y install "Compute Node" --releasever=7 --installroot=/opt/diskless/images/image1

cat << EOF > /opt/diskless/images/image1
none    /tmp        tmpfs   defaults   0 0
tmpfs   /dev/shm    tmpfs   defaults   0 0
sysfs   /sys        sysfs   defaults   0 0
proc    /proc       proc    defaults   0 0
EOF

# - For livedCD
#/dev/root  /         ext4    defaults,noatime 0 0
#devpts     /dev/pts  devpts  gid=5,mode=620   0 0
#tmpfs      /dev/shm  tmpfs   defaults         0 0
#proc       /proc     proc    defaults         0 0
#sysfs      /sys      sysfs   defaults         0 0

#choort and make new initrd's
#yum -y install dracut-network nfs-utils
#dracut -N -a livenet -a dmsquash-live -f -v  /boot/initramfs-3.10.0-957.21.3.el7.x86_64.img  3.10.0-957.21.3.el7.x86_64
#also do root password


