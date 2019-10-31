pipework --direct-phys p3p1_0 -i veth0 testpmd    10.1.1.50/16
pipework --direct-phys p3p1_1 -i veth1 testpmd    10.1.1.51/16
pipework --direct-phys p3p1_2 -i veth0 pktgen     10.1.1.52/16
pipework --direct-phys p3p1_3 -i veth1 pktgen     10.1.1.53/16
