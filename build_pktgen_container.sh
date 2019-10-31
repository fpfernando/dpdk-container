
#!/bin/bash

DOCKER_BUILD_DIR="$CONTAINER_DIR/docker-build/pktgen"
DOCKER_TAG="pktgen"

cd "$DOCKER_BUILD_DIR"

docker build . -t $DOCKER_TAG
