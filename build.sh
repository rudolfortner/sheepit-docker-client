#!/bin/bash

# END SCRIPT ON FAILURE
set -e

# RETRIEVE VERSION TAG
URL=https://www.sheepit-renderfarm.com/media/applet/client-latest.php
LATEST_VERSION=$(curl --connect-timeout 20 --retry 4 --silent --show-error --head "$URL" |
    grep -Po '(?i)content-disposition:.*filename="?sheepit-client-\K\d+(?:\.\d+)*')
    
# CHECK LATEST VERSION
if [[ -z "$LATEST_VERSION" ]]; then
    echo "ERROR: Could not determine latest version."
    exit 1
fi

# CHECK CURRENT IMAGE VERSION
REMOTE_IMAGE=$(docker buildx imagetools inspect "ghcr.io/rudolfortner/sheepit-docker-client:$LATEST_VERSION" 2>/dev/null)

if [[ -n "$REMOTE_IMAGE" ]]; then
    echo "Version $LATEST_VERSION already exists in GHCR."
    echo "Nothing to build."
    exit 0
fi

# BUILD CONTAINER
echo "Building image for $LATEST_VERSION"
docker build . \
	-t sheepit-docker-client:latest	\
	-t sheepit-docker-client:$LATEST_VERSION

# TAGS FOR GHCR
docker tag sheepit-docker-client:latest ghcr.io/rudolfortner/sheepit-docker-client:latest
docker tag sheepit-docker-client:$LATEST_VERSION ghcr.io/rudolfortner/sheepit-docker-client:$LATEST_VERSION

# PUSH TO GHCR
docker push ghcr.io/rudolfortner/sheepit-docker-client:latest
docker push ghcr.io/rudolfortner/sheepit-docker-client:$LATEST_VERSION
