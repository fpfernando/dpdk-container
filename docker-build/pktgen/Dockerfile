FROM testpmd
COPY ./pktgen-build /root/pktgen-build
WORKDIR /root/pktgen-build
COPY ./pktgen /usr/src/pktgen
COPY ./lua /root/lua

RUN yum -y install libpcap-devel
RUN yum -y install wireshark
RUN yum -y install sudo

ENV PKTGEN_DIR "/usr/src/pktgen"
RUN ./build_pktgen.sh; exit 0 #for some reason, the first time always fails, so we do this twice (??)
RUN sh build_pktgen.sh
CMD ["/bin/bash"]
