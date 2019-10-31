
#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo "Cleanup: Before Git Upload."
# Cleanup of prev installed files
rm -rf /home/ddosuser/dpdk-container/docker-build/testpmd/dpdk
rm -rf /home/ddosuser/dpdk-container/docker-build/testpmd/rpms
rm -rf /home/ddosuser/dpdk-container/docker-build/pktgen/pktgen
rm -rf /home/ddosuser/dpdk-container/docker-build/pktgen/lua
rm -rf /home/ddosuser/dpdk-container/docker-build/pktgen/rpms
rm -rf /home/ddosuser/dpdk-container/dpdk

echo "Unmounting hugepages"
umount nodev /mnt/huge

echo "Deleting huge page memory files..."
rm -rf /dev/hugepages/*

echo "Show the fs table's hugepage mounts"
mount | grep -i huge

echo "De-allocating hugepages"
echo 0  > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

echo "Show free/used hugepage info"
cat /proc/meminfo | grep -i huge

echo "Removing from the kernel any DPDK drivers that may still be in use"
#rmmod i40e
#rmmod ixgbe
rmmod igb_uio
rmmod cuse
rmmod fuse
rmmod openvswitch
rmmod uio
rmmod eventfd_link
rmmod ioeventfd


echo "Cleanup VFs, remove VFs"
echo 0 > /sys/class/net/p3p1/device/sriov_numvfs

