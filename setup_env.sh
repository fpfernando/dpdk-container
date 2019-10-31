#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

source env_variables

echo "Cleanup Prev Downloaded Files."
cd $HOMEDIR
sh cleanup_b4_git_upload.sh

echo "Setup VFs, create 6 VFs"
echo 6 > /sys/class/net/p3p1/device/sriov_numvfs

echo "Download DPDK."
URL=https://git.dpdk.org/dpdk/snapshot/dpdk-19.08.tar.gz
BASEDIR=/home/ddosuser/dpdk-container/docker-build/testpmd

cd $BASEDIR
curl $URL | tar xz

mv dpdk-19.08 dpdk
ln -s /home/ddosuser/dpdk-container/docker-build/testpmd/dpdk /home/ddosuser/dpdk-container/dpdk

echo "Download PktGen."
URL=https://git.dpdk.org/apps/pktgen-dpdk/snapshot/pktgen-19.08.0.tar.gz
BASEDIR=/home/ddosuser/dpdk-container/docker-build/pktgen

cd $BASEDIR
curl $URL | tar xz

mv pktgen-19.08.0 pktgen


echo "Download Lua."
URL=http://www.lua.org/ftp/lua-5.3.5.tar.gz
BASEDIR=/home/ddosuser/dpdk-container/docker-build/pktgen

cd $BASEDIR
curl $URL | tar xz

mv lua-5.3.5 lua 


echo "Download 693 kernel headers and devel package"
yum -y install wget 
BASEDIR=/home/ddosuser/dpdk-container/docker-build/testpmd
mkdir $BASEDIR/rpms
cd $BASEDIR/rpms
wget ftp://ftp.pbone.net/mirror/ftp.scientificlinux.org/linux/scientific/7.0/x86_64/updates/security/kernel-3.10.0-693.el7.x86_64.rpm

wget ftp://ftp.pbone.net/mirror/ftp.scientificlinux.org/linux/scientific/7.0/x86_64/updates/security/kernel-devel-3.10.0-693.el7.x86_64.rpm

wget ftp://ftp.pbone.net/mirror/ftp.scientificlinux.org/linux/scientific/7.0/x86_64/updates/security/kernel-headers-3.10.0-693.21.1.el7.x86_64.rpm

yum install -y numactl-devel
yum install -y gcc 

echo "Build DPDK"
cd $DPDK_DIR
make config O="$DPDK_BUILD" T="$DPDK_BUILD"
cd "$DPDK_BUILD"
make -j8

echo "Re-allocating hugepages"
echo echo 8  > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

echo "Mounting the hugepage tlfs"
mount -t hugetlbfs none /mnt/huge

echo "Show the fs table:"
mount | grep -i huge

echo "Inserting the user-space IO driver into the kernel"
modprobe uio
insmod $DPDK_DIR/$DPDK_BUILD/kmod/igb_uio.ko

echo "Show free/used hugepage info"
cat /proc/meminfo | grep -i huge

modprobe vfio-pci
echo "Done."
