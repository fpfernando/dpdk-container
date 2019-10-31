
FROM centos:7.4.1708
COPY ./dpdk-build /root/dpdk-build
WORKDIR /root/dpdk-build
COPY ./dpdk /usr/src/dpdk
COPY ./rpms /root/rpms

# Prepare for Kernel 693
#
RUN yum -y install gcc make cmake automake python3-pip libcap-devel gawk pciutils 
RUN yum -y install linux-firmware grubby initscripts 
RUN yum -y remove kernel-headers
RUN yum -y remove kernel-devel

RUN rpm -ivh /root/rpms/kernel-3.10.0-693.el7.x86_64.rpm
RUN rpm -ivh /root/rpms/kernel-devel-3.10.0-693.el7.x86_64.rpm
RUN rpm -ivh /root/rpms/kernel-headers-3.10.0-693.21.1.el7.x86_64.rpm


#Install the dependencies
#
RUN yum -y install numactl-devel
RUN yum -y install gcc
RUN yum -y install readline-devel
RUN yum -y install libpcap
RUN yum -y install vim kmod
RUN yum -y install wireshark
RUN pip3 install -U pip six

# DPDK Related Stuff
ENV DPDK_DIR "/usr/src/dpdk"
ENV DPDK_BUILD "x86_64-native-linuxapp-gcc"
ENV RTE_SDK "/usr/src/dpdk"
ENV RTE_TARGET "x86_64-native-linuxapp-gcc"
RUN sh /root/dpdk-build/build_dpdk.sh
RUN sh /root/dpdk-build/build_testpmd.sh
CMD ["/bin/bash"]
