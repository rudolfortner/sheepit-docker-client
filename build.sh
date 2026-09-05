#!/bin/bash

# RETRIEVE VERSION TAG
URL=https://www.sheepit-renderfarm.com/media/applet/client-latest.php
LATEST_VERSION=$(curl --connect-timeout 20 --retry 4 --silent --show-error --head "$URL" |
    grep -Po '(?i)content-disposition:.*filename="?sheepit-client-\K\d+(?:\.\d+)*')

# BUILD CONTAINER
docker build .						\
	-t sheepit-docker-client:latest			\
	-t sheepit-docker-client:$LATEST_VERSION

# TAGS FR GHCR
docker tag sheepit-docker-client:latest ghcr.io/rudolfortner/sheepit-docker-client:latest
docker tag sheepit-docker-client:$LATEST_VERSION ghcr.io/rudolfortner/sheepit-docker-client:$LATEST_VERSION

# PUSH TO GHCR
docker push ghcr.io/rudolfortner/sheepit-docker-client:latest
docker push ghcr.io/rudolfortner/sheepit-docker-client:$LATEST_VERSION
