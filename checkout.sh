#!/bin/bash
set -e

BRANCH="origin/master"
TAG=$(git tag --merged "$BRANCH" --sort=-version:refname | head -n 1)

if [[ -z "$TAG" ]]; then
  echo "Error: No version tag found on $BRANCH"
  exit 1
fi

echo "Checking out latest version tag: $TAG"
git checkout "$TAG"
