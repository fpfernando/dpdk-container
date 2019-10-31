# dpdk-container
Docker file to run DPDK in a container with SR-IOV support

Prereq:
1. Enable SR-IOV (In BIOS and set up iommu in the grub) 
2. Install pipework 
  git clone https://github.com/jpetazzo/pipework 
  cp pipework/pipework /usr/bin 

Run the following scripts to create the image, start the container and associate the VF to the name space of the container

1. setup_env.sh
2. build_testpmd.sh
3. build_pktgen.sh
4. run_testpmd.sh
5. run_pktgen.sh
6. pipework.sh

