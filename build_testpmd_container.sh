
#!/bin/bash

DOCKER_BUILD_DIR="$CONTAINER_DIR/docker-build/testpmd"
DOCKER_TAG="testpmd"

cd "$DOCKER_BUILD_DIR"

docker build . -t $DOCKER_TAG
