
#!/bin/bash

if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

export DOCKER_TAG="testpmd"

echo "Launching docker container in privileged mode with access to host hugepages"
CMD="docker run --name $DOCKER_TAG --hostname $DOCKER_TAG -d -tiv /mnt/huge:/mnt/huge --privileged $DOCKER_TAG"
echo "Running $CMD"
$CMD
