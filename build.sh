#!/bin/bash

# END SCRIPT ON FAILURE
set -e

# RETRIEVE SHEEPIT VERSION
URL=https://www.sheepit-renderfarm.com/media/applet/client-latest.php
SHEEPIT_VERSION=$(curl --connect-timeout 20 --retry 4 --silent --show-error --head "$URL" |
    grep -Po '(?i)content-disposition:.*filename="?sheepit-client-\K\d+(?:\.\d+)*')

# CHECK SHEEPIT VERSION
if [[ -z "$SHEEPIT_VERSION" ]]; then
    echo "ERROR: Could not determine sheepit version"
    exit 1
fi

# RETRIEVE REPO VERSION
REPO_VERSION=$(git describe --tags 2>/dev/null) || REPO_VERSION=""

# CHECK CONTAINER VERSION
if [[ -z $REPO_VERSION ]]; then
    echo "ERROR: No version tag found"
    exit 1
fi

# CREATE IMAGE VERSION TAG
VERSION="$REPO_VERSION-$SHEEPIT_VERSION"

# CHECK CURRENT IMAGE VERSION
REMOTE_IMAGE=$(docker buildx imagetools inspect "ghcr.io/rudolfortner/sheepit-docker-client:$VERSION" 2>/dev/null) || REMOTE_IMAGE=""

if [[ -n "$REMOTE_IMAGE" ]]; then
    echo "Version $VERSION already exists in GHCR."
    echo "Nothing to build."
    exit 0
fi

# BUILD CONTAINER
echo "Building image for $VERSION"
docker build . \
	-t sheepit-docker-client:latest	\
	-t sheepit-docker-client:$VERSION

# TAGS FOR GHCR
docker tag sheepit-docker-client:latest ghcr.io/rudolfortner/sheepit-docker-client:latest
docker tag sheepit-docker-client:$VERSION ghcr.io/rudolfortner/sheepit-docker-client:$VERSION

# PUSH TO GHCR
docker push ghcr.io/rudolfortner/sheepit-docker-client:latest
docker push ghcr.io/rudolfortner/sheepit-docker-client:$VERSION
