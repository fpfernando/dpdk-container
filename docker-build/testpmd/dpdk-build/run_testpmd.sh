

#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

if [ "$DPDK_DIR" == "" ]; then
	echo "Sorry, DPDK_DIR env var has not been set to root of DPDK src tree"
	exit 1
fi

export TESTPMD_PARAMS="-l 0-3 -n 4 -- -i --portmask=0x1 --nb-cores=2" 

CMD="$DPDK_DIR/app/test-pmd/testpmd $TESTPMD_PARAMS"
echo "Running $CMD"
$CMD
