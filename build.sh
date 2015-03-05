#!/bin/bash

OWNER=dleehr
for IMAGE in `ls`; do
  if [ -f $IMAGE/Dockerfile ]; then
    echo "Building $IMAGE"
    docker build -t $OWNER/$IMAGE $IMAGE
  fi
done